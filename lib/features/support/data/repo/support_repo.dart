import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:sammly/core/networking/api_constants.dart';
import 'package:sammly/core/networking/dio_helper.dart';
import 'package:sammly/core/utils/backend_message_translator.dart';

class SupportRepo {
  static String _t(String msg) => BackendMessageTranslator.translate(msg);

  /// Send support request
  /// POST /api/support
  Future<Either<String, String>> sendSupportRequest({
    required String email,
    required String subject,
    required String message,
  }) async {
    try {
      final response = await DioHelper.postData(
        endPoint: ApiConstants.support,
        data: {'guestEmail': email, 'subject': subject, 'message': message},
      );

      if (response.statusCode == 201) {
        return right(_t(response.data['message'] ?? 'Support request sent.'));
      } else {
        return left(_t(response.data['message'] ?? 'Failed to send request.'));
      }
    } on DioException catch (e) {
      return left(_handleDioError(e));
    } catch (e) {
      return left(_t('An unexpected error occurred.'));
    }
  }

  /// Centralized Dio error handler
  String _handleDioError(DioException e) {
    if (e.response != null && e.response?.data != null) {
      try {
        final data = e.response!.data;
        if (data is Map) {
          final msg =
              data['message'] ??
              data['msg'] ??
              (data['data'] is Map
                  ? (data['data']['msg'] ?? data['data']['message'])
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
      case DioExceptionType.badResponse:
        return _t('Bad response: ${e.response?.statusCode} - ${e.message}');
      default:
        return _t('Error: ${e.message ?? e.error ?? 'Something went wrong.'}');
    }
  }
}
