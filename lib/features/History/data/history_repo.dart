import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:sammly/core/networking/api_constants.dart';
import 'package:sammly/core/networking/dio_helper.dart';
import 'package:sammly/core/shared_pref/shared_pref.dart';
import 'package:sammly/features/History/data/historymodel.dart';

class HistoryRepo {
  Future<Either<String, HistoryResponse>> getHistory({
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final token = SharedPref.getData(key: 'jwt');
      if (token == null) {
        return left('Unauthorized: No token found.');
      }

      // Clamp pagination values
      if (page < 1) page = 1;
      if (limit < 1) limit = 20;
      if (limit > 50) limit = 50;

      final response = await DioHelper.getData(
        endPoint: ApiConstants.designHistory,
        queryParameters: {
          'page': page,
          'limit': limit,
        },
        token: token,
      );

      if (response.statusCode == 200 && response.data['status'] == 'success') {
        final data = response.data['data'] as Map<String, dynamic>;
        return right(HistoryResponse.fromJson(data));
      } else {
        log(response.data.toString());
        return left(response.data['message'] ?? 'Failed to load design history.');
      }
    } on DioException catch (e) {
      return left(_handleDioError(e));
    } catch (e) {
      log('History error: $e');
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
              ?? (data['errors'] is List ? (data['errors'] as List).join(', ') : null);
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
