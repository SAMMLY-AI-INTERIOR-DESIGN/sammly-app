import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:sammly/core/networking/api_constants.dart';
import 'package:sammly/core/networking/dio_helper.dart';
import 'package:sammly/core/shared_pref/shared_pref.dart';
import 'package:sammly/core/utils/backend_message_translator.dart';
import 'package:sammly/features/Explore/data/public_profile_model.dart';

class PublicProfileRepo {
  static String _t(String msg) => BackendMessageTranslator.translate(msg);

  Future<Either<String, PublicProfileModel>> getPublicProfile({
    required String userId,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final token = SharedPref.getData(key: 'jwt');
      if (token == null) {
        return Left(_t('Unauthorized: No token found.'));
      }

      final response = await DioHelper.getData(
        endPoint: ApiConstants.publicProfile(userId),
        queryParameters: {
          'page': page,
          'limit': limit,
        },
        token: token,
      );

      if (response.statusCode == 200 && response.data['status'] == 'success') {
        final model = PublicProfileModel.fromJson(response.data['data']);
        return Right(model);
      } else {
        log(response.data.toString());
        return Left(_t(response.data['message'] ?? 'Unknown error'));
      }
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      log('Public profile error: $e');
      return Left(_t('An unexpected error occurred.'));
    }
  }

  String _handleDioError(DioException e) {
    if (e.response != null && e.response?.data != null) {
      try {
        final data = e.response!.data;
        log('API Error Response: $data');
        if (data is Map) {
          final msg = data['message'] ??
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
