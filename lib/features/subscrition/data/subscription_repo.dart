import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:sammly/core/networking/api_constants.dart';
import 'package:sammly/core/networking/dio_helper.dart';
import 'package:sammly/core/shared_pref/shared_pref.dart';
import 'package:sammly/core/utils/backend_message_translator.dart';

class SubscriptionRepo {
  static String _t(String msg) => BackendMessageTranslator.translate(msg);

  /// Fetches all available packages from the API.
  Future<Either<String, List<PackageModel>>> getPackages() async {
    try {
      final token = SharedPref.getData(key: 'jwt');
      if (token == null) {
        return left(_t('Unauthorized: No token found.'));
      }

      final response = await DioHelper.getData(
        endPoint: ApiConstants.getPackages,
        token: token,
      );

      if (response.statusCode == 200 && response.data['status'] == 'success') {
        final data = response.data['data'] as Map<String, dynamic>;
        final packagesJson = data['packages'] as List;
        final packages =
            packagesJson.map((e) => PackageModel.fromJson(e)).toList();
        return right(packages);
      } else {
        return left(_t(response.data['message'] ?? 'Failed to load packages.'));
      }
    } on DioException catch (e) {
      return left(_handleDioError(e));
    } catch (e) {
      log('Get packages error: $e');
      return left(_t('An unexpected error occurred.'));
    }
  }

  /// Subscribes to a package via the backend.
  /// POST /api/payment/subscribe with { packageId: string }
  Future<Either<String, ClaimResult>> claimPackage(String packageId) async {
    try {
      final token = SharedPref.getData(key: 'jwt');
      if (token == null) {
        return left(_t('Unauthorized: No token found.'));
      }

      final response = await DioHelper.postData(
        endPoint: ApiConstants.claimPackage,
        data: {'packageId': packageId},
        token: token,
      );

      if (response.statusCode == 200 && response.data['status'] == 'success') {
        final message = response.data['message'] ?? '';
        final data = response.data['data'];
        final credits = data != null ? (data['credits'] ?? data['tokens']) : null;
        return right(ClaimResult(message: _t(message), credits: credits));
      } else {
        return left(_t(response.data['message'] ?? 'Failed to subscribe.'));
      }
    } on DioException catch (e) {
      return left(_handleDioError(e));
    } catch (e) {
      log('Subscribe error: $e');
      return left(_t('An unexpected error occurred.'));
    }
  }


  String _handleDioError(DioException e) {
    if (e.response?.statusCode == 404) {
      return _t('soon');
    }
    if (e.response != null && e.response?.data != null) {
      try {
        final data = e.response!.data;
        if (data is Map) {
          final msg = data['message'] ?? data['error'];
          if (msg != null) return _t(msg.toString());
        }
      } catch (_) {}
    }
    return _t('Network error occurred');
  }
}

class PackageModel {
  final String packageId;
  final int credits;
  final int price;
  final String? type; // 'free', 'consumable', 'subscription'
  final String? iapProductId; // Maps to store product ID

  PackageModel({
    required this.packageId,
    required this.credits,
    required this.price,
    this.type,
    this.iapProductId,
  });

  factory PackageModel.fromJson(Map<String, dynamic> json) {
    return PackageModel(
      packageId: json['packageId'] ?? '',
      // Backend may send 'tokens' or 'credits'
      credits: json['credits'] ?? json['tokens'] ?? 0,
      price: (json['price'] ?? 0) is double
          ? (json['price'] as double).toInt()
          : json['price'] ?? 0,
      type: json['type'],
      iapProductId: json['iapProductId'],
    );
  }

  bool get isFree => packageId == 'free';
}

class ClaimResult {
  final String message;
  final int? credits;

  ClaimResult({required this.message, this.credits});
}
