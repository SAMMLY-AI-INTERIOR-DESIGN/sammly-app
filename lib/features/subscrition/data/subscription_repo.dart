import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:sammly/core/networking/api_constants.dart';
import 'package:sammly/core/networking/dio_helper.dart';
import 'package:sammly/core/shared_pref/shared_pref.dart';

class SubscriptionRepo {
  /// Fetches all available packages from the API.
  Future<Either<String, List<PackageModel>>> getPackages() async {
    try {
      final token = SharedPref.getData(key: 'jwt');
      if (token == null) {
        return left('Unauthorized: No token found.');
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
        return left(response.data['message'] ?? 'Failed to load packages.');
      }
    } on DioException catch (e) {
      return left(_handleDioError(e));
    } catch (e) {
      log('Get packages error: $e');
      return left('An unexpected error occurred.');
    }
  }

  /// Claims a package (free gives tokens, others return "soon").
  Future<Either<String, ClaimResult>> claimPackage(String packageId) async {
    try {
      final token = SharedPref.getData(key: 'jwt');
      if (token == null) {
        return left('Unauthorized: No token found.');
      }

      final response = await DioHelper.getData(
        endPoint: ApiConstants.claimPackage,
        data: {'packageId': packageId},
        token: token,
      );

      if (response.statusCode == 200 && response.data['status'] == 'success') {
        final message = response.data['message'] ?? '';
        final data = response.data['data'];
        final tokens = data != null ? data['tokens'] : null;
        return right(ClaimResult(message: message, tokens: tokens));
      } else {
        return left(response.data['message'] ?? 'Failed to claim package.');
      }
    } on DioException catch (e) {
      return left(_handleDioError(e));
    } catch (e) {
      log('Claim package error: $e');
      return left('An unexpected error occurred.');
    }
  }

  String _handleDioError(DioException e) {
    if (e.response != null && e.response?.data != null) {
      try {
        final data = e.response!.data;
        if (data is Map) {
          final msg = data['message'] ?? data['error'];
          if (msg != null) return msg.toString();
        }
      } catch (_) {}
    }
    return 'Network error occurred';
  }
}

class PackageModel {
  final String packageId;
  final int tokens;
  final int price;

  PackageModel({
    required this.packageId,
    required this.tokens,
    required this.price,
  });

  factory PackageModel.fromJson(Map<String, dynamic> json) {
    return PackageModel(
      packageId: json['packageId'] ?? '',
      tokens: json['tokens'] ?? 0,
      price: (json['price'] ?? 0) is double
          ? (json['price'] as double).toInt()
          : json['price'] ?? 0,
    );
  }

  bool get isFree => packageId == 'free';
}

class ClaimResult {
  final String message;
  final int? tokens;

  ClaimResult({required this.message, this.tokens});
}
