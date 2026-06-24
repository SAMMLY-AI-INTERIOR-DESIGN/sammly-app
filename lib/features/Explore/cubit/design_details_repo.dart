import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:sammly/core/networking/api_constants.dart';
import 'package:sammly/core/networking/dio_helper.dart';
import 'package:sammly/core/shared_pref/shared_pref.dart';
import 'package:sammly/core/utils/backend_message_translator.dart';
import 'package:sammly/features/Explore/data/design_details_model.dart';

class DesignDetailsRepo {
  static String _t(String msg) => BackendMessageTranslator.translate(msg);

  /// GET /api/designs/:designId
  Future<Either<String, DesignDetailsResponse>> getDesignDetails(
    String designId,
  ) async {
    try {
      final token = SharedPref.getData(key: 'jwt');
      if (token == null) return left(_t('Unauthorized: No token found.'));

      final response = await DioHelper.getData(
        endPoint: ApiConstants.designDetails(designId),
        token: token,
      );

      if (response.statusCode == 200 && response.data['status'] == 'success') {
        final data = response.data['data'] as Map<String, dynamic>;
        return right(DesignDetailsResponse.fromJson(data));
      } else {
        return left(
          _t(response.data['message'] ?? 'Failed to load design details.'),
        );
      }
    } on DioException catch (e) {
      return left(_handleDioError(e));
    } catch (e) {
      log('Design details error: $e');
      return left(_t('An unexpected error occurred.'));
    }
  }

  /// PATCH /api/designs/:designId/share
  Future<Either<String, String>> shareDesign(String designId) async {
    try {
      final token = SharedPref.getData(key: 'jwt');
      if (token == null) return left(_t('Unauthorized: No token found.'));

      final response = await DioHelper.patchData(
        endPoint: ApiConstants.shareDesign(designId),
        data: {},
        token: token,
      );

      if (response.statusCode == 200 && response.data['status'] == 'success') {
        final message =
            response.data['data']['message'] ?? 'Design shared successfully';
        return right(_t(message));
      } else {
        return left(_t(response.data['message'] ?? 'Failed to share design.'));
      }
    } on DioException catch (e) {
      return left(_handleDioError(e));
    } catch (e) {
      log('Share design error: $e');
      return left(_t('An unexpected error occurred.'));
    }
  }

  /// PATCH /api/designs/:designId/cancel-share
  Future<Either<String, String>> cancelShareDesign(String designId) async {
    try {
      final token = SharedPref.getData(key: 'jwt');
      if (token == null) return left(_t('Unauthorized: No token found.'));

      final response = await DioHelper.patchData(
        endPoint: ApiConstants.cancelShareDesign(designId),
        data: {},
        token: token,
      );

      if (response.statusCode == 200 && response.data['status'] == 'success') {
        final message =
            response.data['data']['message'] ?? 'Sharing canceled successfully';
        return right(_t(message));
      } else {
        return left(_t(response.data['message'] ?? 'Failed to cancel sharing.'));
      }
    } on DioException catch (e) {
      return left(_handleDioError(e));
    } catch (e) {
      log('Cancel share error: $e');
      return left(_t('An unexpected error occurred.'));
    }
  }

  /// POST /api/designs/:designId/like
  Future<Either<String, String>> likeDesign(String designId) async {
    try {
      final token = SharedPref.getData(key: 'jwt');
      if (token == null) return left(_t('Unauthorized: No token found.'));

      final endpoint = ApiConstants.likeDesign(designId);
      log('Like design → endpoint: $endpoint, designId: $designId');

      DioHelper.dio.options.headers['Authorization'] = 'Bearer $token';
      final response = await DioHelper.dio.post(
        endpoint,
        data: {},
        options: Options(
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      log('Like response: ${response.statusCode} → ${response.data}');

      if ((response.statusCode == 200 || response.statusCode == 201) &&
          response.data['status'] == 'success') {
        final message =
            response.data['data']?['message'] ?? 'Design liked successfully';
        return right(_t(message));
      } else {
        return left(_t(response.data['message'] ?? 'Failed to like design.'));
      }
    } on DioException catch (e) {
      return left(_handleDioError(e));
    } catch (e) {
      log('Like design error: $e');
      return left(_t('An unexpected error occurred.'));
    }
  }

  /// DELETE /api/designs/:designId/like
  Future<Either<String, String>> unlikeDesign(String designId) async {
    try {
      final token = SharedPref.getData(key: 'jwt');
      if (token == null) return left(_t('Unauthorized: No token found.'));

      final endpoint = ApiConstants.likeDesign(designId);
      log('Unlike design → endpoint: $endpoint, designId: $designId');

      DioHelper.dio.options.headers['Authorization'] = 'Bearer $token';
      final response = await DioHelper.dio.delete(
        endpoint,
        options: Options(
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      log('Unlike response: ${response.statusCode} → ${response.data}');

      if (response.statusCode == 200 && response.data['status'] == 'success') {
        final message =
            response.data['data']?['message'] ?? 'Design unliked successfully';
        return right(_t(message));
      } else {
        return left(_t(response.data['message'] ?? 'Failed to unlike design.'));
      }
    } on DioException catch (e) {
      return left(_handleDioError(e));
    } catch (e) {
      log('Unlike design error: $e');
      return left(_t('An unexpected error occurred.'));
    }
  }

  String _handleDioError(DioException e) {
    if (e.response != null && e.response?.data != null) {
      try {
        final data = e.response!.data;
        log('API Error Response: $data');
        if (data is Map) {
          final msg =
              data['message'] ??
              data['msg'] ??
              data['error'] ??
              (data['errors'] is List
                  ? (data['errors'] as List).join(', ')
                  : null);
          if (msg != null) return _t(msg.toString());
        }
      } catch (_) {}
    }

    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return _t('Server Failed Connection , Try again');
      default:
        return _t('Network error occurred');
    }
  }
}
