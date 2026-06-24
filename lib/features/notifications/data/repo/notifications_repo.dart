import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:sammly/core/networking/api_constants.dart';
import 'package:sammly/core/networking/dio_helper.dart';
import 'package:sammly/core/shared_pref/shared_pref.dart';
import 'package:sammly/core/utils/backend_message_translator.dart';
import 'package:sammly/features/notifications/data/model/notifications_model.dart';

class NotificationsRepo {
  static String _t(String msg) => BackendMessageTranslator.translate(msg);

  Future<Either<String, NotificationsResponse>> getNotifications({
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final token = SharedPref.getData(key: 'jwt');
      if (token == null) {
        return left(_t('Unauthorized: No token found.'));
      }

      if (page < 1) page = 1;
      if (limit < 1) limit = 20;
      if (limit > 50) limit = 50;

      final response = await DioHelper.getData(
        endPoint: ApiConstants.getNotifications,
        queryParameters: {'page': page, 'limit': limit},
        token: token,
      );

      if (response.statusCode == 200 && response.data['status'] == 'success') {
        final data = response.data['data'] as Map<String, dynamic>;
        return right(NotificationsResponse.fromJson(data));
      } else {
        return left(
          _t(response.data['message'] ?? 'Failed to load notifications.'),
        );
      }
    } on DioException catch (e) {
      return left(_handleDioError(e));
    } catch (e) {
      log('Get notifications error: $e');
      return left(_t('An unexpected error occurred.'));
    }
  }

  String _handleDioError(DioException e) {
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
