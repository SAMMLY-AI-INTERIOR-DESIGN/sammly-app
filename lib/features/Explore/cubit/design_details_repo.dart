import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:sammly/core/networking/api_constants.dart';
import 'package:sammly/core/networking/dio_helper.dart';
import 'package:sammly/core/shared_pref/shared_pref.dart';
import 'package:sammly/features/Explore/data/design_details_model.dart';

class DesignDetailsRepo {
  /// GET /api/designs/:designId
  Future<Either<String, DesignDetailsResponse>> getDesignDetails(
    String designId,
  ) async {
    try {
      final token = SharedPref.getData(key: 'jwt');
      if (token == null) return left('Unauthorized: No token found.');

      final response = await DioHelper.getData(
        endPoint: ApiConstants.designDetails(designId),
        token: token,
      );

      if (response.statusCode == 200 && response.data['status'] == 'success') {
        final data = response.data['data'] as Map<String, dynamic>;
        return right(DesignDetailsResponse.fromJson(data));
      } else {
        return left(response.data['message'] ?? 'Failed to load design details.');
      }
    } on DioException catch (e) {
      return left(_handleDioError(e));
    } catch (e) {
      log('Design details error: $e');
      return left('An unexpected error occurred.');
    }
  }

  /// PATCH /api/designs/:designId/share
  Future<Either<String, String>> shareDesign(String designId) async {
    try {
      final token = SharedPref.getData(key: 'jwt');
      if (token == null) return left('Unauthorized: No token found.');

      final response = await DioHelper.patchData(
        endPoint: ApiConstants.shareDesign(designId),
        token: token,
      );

      if (response.statusCode == 200 && response.data['status'] == 'success') {
        final message = response.data['data']['message'] ?? 'Design shared successfully';
        return right(message);
      } else {
        return left(response.data['message'] ?? 'Failed to share design.');
      }
    } on DioException catch (e) {
      return left(_handleDioError(e));
    } catch (e) {
      log('Share design error: $e');
      return left('An unexpected error occurred.');
    }
  }

  /// PATCH /api/designs/:designId/cancel-share
  Future<Either<String, String>> cancelShareDesign(String designId) async {
    try {
      final token = SharedPref.getData(key: 'jwt');
      if (token == null) return left('Unauthorized: No token found.');

      final response = await DioHelper.patchData(
        endPoint: ApiConstants.cancelShareDesign(designId),
        token: token,
      );

      if (response.statusCode == 200 && response.data['status'] == 'success') {
        final message = response.data['data']['message'] ?? 'Sharing canceled successfully';
        return right(message);
      } else {
        return left(response.data['message'] ?? 'Failed to cancel sharing.');
      }
    } on DioException catch (e) {
      return left(_handleDioError(e));
    } catch (e) {
      log('Cancel share error: $e');
      return left('An unexpected error occurred.');
    }
  }

  /// POST /api/designs/:designId/like
  Future<Either<String, String>> likeDesign(String designId) async {
    try {
      final token = SharedPref.getData(key: 'jwt');
      if (token == null) return left('Unauthorized: No token found.');

      final response = await DioHelper.postData(
        endPoint: ApiConstants.likeDesign(designId),
        data: {},
        token: token,
      );

      if ((response.statusCode == 200 || response.statusCode == 201) &&
          response.data['status'] == 'success') {
        final message = response.data['data']['message'] ?? 'Design liked successfully';
        return right(message);
      } else {
        return left(response.data['message'] ?? 'Failed to like design.');
      }
    } on DioException catch (e) {
      return left(_handleDioError(e));
    } catch (e) {
      log('Like design error: $e');
      return left('An unexpected error occurred.');
    }
  }

  /// DELETE /api/designs/:designId/like
  Future<Either<String, String>> unlikeDesign(String designId) async {
    try {
      final token = SharedPref.getData(key: 'jwt');
      if (token == null) return left('Unauthorized: No token found.');

      final response = await DioHelper.deleteData(
        endPoint: ApiConstants.likeDesign(designId),
        token: token,
      );

      if (response.statusCode == 200 && response.data['status'] == 'success') {
        final message = response.data['data']['message'] ?? 'Design unliked successfully';
        return right(message);
      } else {
        return left(response.data['message'] ?? 'Failed to unlike design.');
      }
    } on DioException catch (e) {
      return left(_handleDioError(e));
    } catch (e) {
      log('Unlike design error: $e');
      return left('An unexpected error occurred.');
    }
  }

  String _handleDioError(DioException e) {
    if (e.response != null && e.response?.data != null) {
      try {
        final data = e.response!.data;
        log('API Error Response: $data');
        if (data is Map) {
          final msg = data['message']
              ?? data['msg']
              ?? data['error']
              ?? (data['errors'] is List
                  ? (data['errors'] as List).join(', ')
                  : null);
          if (msg != null) return msg.toString();
        }
      } catch (_) {}
    }

    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return 'Server Failed Connection , Try again';
      default:
        return 'Network error occurred';
    }
  }
}
