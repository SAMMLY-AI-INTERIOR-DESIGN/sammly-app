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

  /// Sends imageUrl to POST /api/sourcing/search and returns parsed response.
  Future<Either<String, SearchResponse>> searchByImage(String imageUrl) async {
    try {
      final token = SharedPref.getData(key: 'jwt');
      if (token == null) {
        return left(_t('Unauthorized: No token found.'));
      }

      final response = await DioHelper.postData(
        endPoint: ApiConstants.sourcingSearch,
        data: {'imageUrl': imageUrl},
        token: token,
      );

      if (response.statusCode == 200 && response.data['status'] == 'success') {
        return right(SearchResponse.fromJson(response.data));
      } else {
        log('Sourcing search API error: ${response.data}');
        return left(_t(response.data['message'] ?? 'Failed to search.'));
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
        log('Sourcing Search API Error [$statusCode]: $data');

        if (statusCode == 400) {
          return _t(data['message'] ?? 'Invalid image URL.');
        }
        if (statusCode == 404) {
          return _t(data['message'] ?? 'Not found.');
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
