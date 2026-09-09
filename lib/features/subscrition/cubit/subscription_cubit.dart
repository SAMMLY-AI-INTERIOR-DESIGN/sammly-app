import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sammly/core/services/iap_product_ids.dart';
import 'package:sammly/core/services/iap_service.dart';
import 'package:sammly/features/subscrition/cubit/subscription_states.dart';
import 'package:sammly/features/subscrition/data/subscription_repo.dart';

class SubscriptionCubit extends Cubit<SubscriptionState> {
  @override
  void emit(SubscriptionState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }

  final SubscriptionRepo _repo;
  final IapService _iapService = IapService.instance;
  List<PackageModel> packagesList = [];
  StreamSubscription<IapPurchaseResult>? _iapSubscription;

  SubscriptionCubit(this._repo) : super(SubscriptionInitial()) {
    // Listen to IAP purchase results
    _iapSubscription = _iapService.purchaseStream.listen(_onIapResult);
  }

  void _onIapResult(IapPurchaseResult result) {
    if (isClosed) return;
    if (result.success) {
      emit(PurchaseSuccess(message: result.message, credits: result.credits));
      // Re-emit loaded state so UI rebuilds
      emit(PackagesLoaded(packagesList));
    } else {
      // Don't emit failure for pending messages
      if (result.message != 'Purchase pending...') {
        emit(PurchaseFailure(result.message));
        emit(PackagesLoaded(packagesList));
      }
    }
  }

  Future<void> getPackages() async {
    if (isClosed) return;
    emit(PackagesLoading());

    final result = await _repo.getPackages();
    if (isClosed) return;

    result.fold(
      (error) => emit(PackagesError(error)),
      (packages) {
        packagesList = packages;
        emit(PackagesLoaded(packages));
      },
    );
  }

  /// Claim the free package (backend only, no IAP).
  Future<void> claimPackage(String packageId) async {
    if (isClosed) return;
    emit(SubscriptionLoading(packageId));

    final result = await _repo.claimPackage(packageId);
    if (isClosed) return;

    result.fold(
      (error) => emit(ClaimFailure(error)),
      (claimResult) {
        emit(ClaimSuccess(claimResult));
        // Re-emit loaded state so UI can rebuild packages list if needed
        emit(PackagesLoaded(packagesList));
      },
    );
  }

  /// Purchase a paid package via In-App Purchase.
  Future<void> purchasePackage(String iapProductId) async {
    if (isClosed) return;
    emit(PurchaseInProgress(iapProductId));

    if (!_iapService.isAvailable) {
      emit(PurchaseFailure('Store is not available on this device.'));
      emit(PackagesLoaded(packagesList));
      return;
    }

    final isConsumable = IapProductIds.consumables.contains(iapProductId);

    bool launched;
    if (isConsumable) {
      launched = await _iapService.buyConsumable(iapProductId);
    } else {
      launched = await _iapService.buySubscription(iapProductId);
    }

    if (!launched) {
      if (!isClosed) {
        emit(PurchaseFailure('Could not launch purchase flow.'));
        emit(PackagesLoaded(packagesList));
      }
    }
    // If launched, the result will come through _onIapResult via the stream.
  }

  /// Restore previous purchases.
  Future<void> restorePurchases() async {
    await _iapService.restorePurchases();
  }

  @override
  Future<void> close() {
    _iapSubscription?.cancel();
    return super.close();
  }
}
