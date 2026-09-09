import 'dart:async';
import 'dart:developer';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:sammly/core/networking/api_constants.dart';
import 'package:sammly/core/networking/dio_helper.dart';
import 'package:sammly/core/services/iap_product_ids.dart';
import 'package:sammly/core/shared_pref/shared_pref.dart';

/// Result of an IAP purchase verification with the backend.
class IapPurchaseResult {
  final bool success;
  final String message;
  final int? credits;

  IapPurchaseResult({
    required this.success,
    required this.message,
    this.credits,
  });
}

/// Singleton service to manage In-App Purchases.
///
/// Call [initialize] once at app startup. Then use
/// [buyConsumable] or [buySubscription] to trigger purchases.
/// Listen to [purchaseStream] for purchase state updates.
class IapService {
  IapService._();
  static final IapService instance = IapService._();

  final InAppPurchase _iap = InAppPurchase.instance;
  StreamSubscription<List<PurchaseDetails>>? _subscription;

  /// Products fetched from the store.
  Map<String, ProductDetails> products = {};

  /// Whether the store is available on this device.
  bool isAvailable = false;

  /// Stream controller to broadcast purchase results to the UI.
  final StreamController<IapPurchaseResult> _resultController =
      StreamController<IapPurchaseResult>.broadcast();

  /// Stream that emits purchase results (success/failure).
  Stream<IapPurchaseResult> get purchaseStream => _resultController.stream;

  /// Initialize the IAP service. Call once at app startup.
  Future<void> initialize() async {
    isAvailable = await _iap.isAvailable();
    if (!isAvailable) {
      log('IAP: Store is not available on this device.');
      return;
    }

    // Listen to purchase updates
    _subscription = _iap.purchaseStream.listen(
      _onPurchaseUpdate,
      onDone: () => _subscription?.cancel(),
      onError: (error) {
        log('IAP: Purchase stream error: $error');
      },
    );

    // Fetch products from the store
    await fetchProducts();
  }

  /// Fetch product details from the store.
  Future<void> fetchProducts() async {
    final response = await _iap.queryProductDetails(IapProductIds.all);

    if (response.error != null) {
      log('IAP: Error fetching products: ${response.error}');
      return;
    }

    if (response.notFoundIDs.isNotEmpty) {
      log('IAP: Products not found in store: ${response.notFoundIDs}');
    }

    products = {
      for (final product in response.productDetails) product.id: product,
    };

    log('IAP: Fetched ${products.length} products: ${products.keys.toList()}');
  }

  /// Buy a consumable product (e.g., Homeowner Pack).
  Future<bool> buyConsumable(String productId) async {
    final product = products[productId];
    if (product == null) {
      _resultController.add(IapPurchaseResult(
        success: false,
        message: 'Product not found in store.',
      ));
      return false;
    }

    final purchaseParam = PurchaseParam(productDetails: product);
    return _iap.buyConsumable(purchaseParam: purchaseParam, autoConsume: false);
  }

  /// Buy a subscription product (e.g., Designer Pro, Studio).
  Future<bool> buySubscription(String productId) async {
    final product = products[productId];
    if (product == null) {
      _resultController.add(IapPurchaseResult(
        success: false,
        message: 'Product not found in store.',
      ));
      return false;
    }

    final purchaseParam = PurchaseParam(productDetails: product);
    return _iap.buyNonConsumable(purchaseParam: purchaseParam);
  }

  /// Restore previous purchases (useful for subscriptions).
  Future<void> restorePurchases() async {
    await _iap.restorePurchases();
  }

  /// Handle purchase updates from the store.
  Future<void> _onPurchaseUpdate(List<PurchaseDetails> purchases) async {
    for (final purchase in purchases) {
      log('IAP: Purchase update: ${purchase.productID} → ${purchase.status}');

      switch (purchase.status) {
        case PurchaseStatus.pending:
          // Purchase is pending — show loading indicator in UI
          _resultController.add(IapPurchaseResult(
            success: false,
            message: 'Purchase pending...',
          ));
          break;

        case PurchaseStatus.purchased:
        case PurchaseStatus.restored:
          // Verify with backend
          final result = await _verifyPurchase(purchase);
          _resultController.add(result);

          // Consume if consumable
          if (IapProductIds.consumables.contains(purchase.productID)) {
            await _iap.completePurchase(purchase);
          }
          break;

        case PurchaseStatus.error:
          _resultController.add(IapPurchaseResult(
            success: false,
            message: purchase.error?.message ?? 'Purchase failed.',
          ));
          break;

        case PurchaseStatus.canceled:
          _resultController.add(IapPurchaseResult(
            success: false,
            message: 'Purchase cancelled.',
          ));
          break;
      }

      // Complete pending purchases
      if (purchase.pendingCompletePurchase) {
        await _iap.completePurchase(purchase);
      }
    }
  }

  /// Verify a purchase receipt with the backend.
  Future<IapPurchaseResult> _verifyPurchase(PurchaseDetails purchase) async {
    try {
      final token = SharedPref.getData(key: 'jwt');
      if (token == null) {
        return IapPurchaseResult(
          success: false,
          message: 'Unauthorized: No token found.',
        );
      }

      final response = await DioHelper.postData(
        endPoint: ApiConstants.verifyPurchase,
        data: {
          'productId': purchase.productID,
          'purchaseToken': purchase.verificationData.serverVerificationData,
          'source': purchase.verificationData.source,
        },
        token: token,
      );

      if (response.statusCode == 200 &&
          (response.data['success'] == true ||
              response.data['status'] == 'success')) {
        final credits = response.data['data']?['credits'] ??
            response.data['data']?['tokens'];
        return IapPurchaseResult(
          success: true,
          message: response.data['message'] ?? 'Purchase verified!',
          credits: credits,
        );
      } else {
        return IapPurchaseResult(
          success: false,
          message: response.data['message'] ?? 'Verification failed.',
        );
      }
    } catch (e) {
      log('IAP: Verification error: $e');
      return IapPurchaseResult(
        success: false,
        message: 'Failed to verify purchase.',
      );
    }
  }

  /// Dispose the service.
  void dispose() {
    _subscription?.cancel();
    _resultController.close();
  }
}
