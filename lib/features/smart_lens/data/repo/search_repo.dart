import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:sammly/core/networking/api_constants.dart';
import 'package:sammly/core/networking/dio_helper.dart';
import 'package:sammly/core/shared_pref/shared_pref.dart';
import 'package:sammly/core/utils/backend_message_translator.dart';
import 'package:sammly/features/smart_lens/data/models/search_response.dart';

class SearchRepo {
  static String _t(String msg) => BackendMessageTranslator.translate(msg);

  Future<Either<String, SearchResponse>> searchDesign(String designId) async {
    try {
      final token = SharedPref.getData(key: 'jwt');
      if (token == null) {
        return left(_t('Unauthorized: No token found.'));
      }

      final response = await DioHelper.getData(
        endPoint: ApiConstants.searchDesign(designId),
        token: token,
        receiveTimeout: const Duration(minutes: 4),
        retry: false,
      );

      if (response.statusCode == 200 && response.data['status'] == 'success') {
        return right(SearchResponse.fromJson(response.data));
      } else {
        log('Search API error: ${response.data}');
        return left(_t(response.data['message'] ?? 'Failed to search design.'));
      }
    } on DioException catch (e) {
      return left(_handleDioError(e));
    } catch (e) {
      log('Search error: $e');
      return left(_t('Error: ${e.toString()}'));
    }
  }

  String _handleDioError(DioException e) {
    if (e.response != null && e.response?.data != null) {
      try {
        final data = e.response!.data;
        final statusCode = e.response!.statusCode;
        log('Search API Error [$statusCode]: $data');

        if (statusCode == 400) {
          return _t(data['message'] ?? 'Invalid design ID.');
        }
        if (statusCode == 404) {
          return _t(data['message'] ?? 'Design not found.');
        }

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
        return _t('Server Failed Connection, Try again');
      default:
        return _t('Network error occurred');
    }
  }
}
