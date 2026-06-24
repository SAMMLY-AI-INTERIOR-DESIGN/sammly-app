import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:sammly/core/networking/api_constants.dart';
import 'package:sammly/core/networking/dio_helper.dart';
import 'package:sammly/core/shared_pref/shared_pref.dart';
import 'package:sammly/core/utils/backend_message_translator.dart';
import 'package:sammly/features/home/data/models/home_model.dart';

class HomeRepo {
  static String _t(String msg) => BackendMessageTranslator.translate(msg);

  Future<Either<String, HomeModel>> getHomeData() async {
    try {
      final token = SharedPref.getData(key: 'jwt');
      if (token == null) {
        return left(_t('Unauthorized: No token found.'));
      }

      final response = await DioHelper.getData(
        endPoint: ApiConstants.homeEndpoint,
        token: token,
      );
      // log(response.data.toString());
      if (response.statusCode == 200 && response.data['status'] == 'success') {
        final dataMap = response.data['data'] as Map<String, dynamic>;
        log('Home data: $dataMap');
        return right(HomeModel.fromJson(dataMap));
      } else {
        log(response.data.toString());
        return left(_t(response.data['message'] ?? 'Failed to get home data.'));
      }
    } on DioException catch (e) {
      return left(_handleDioError(e));
    } catch (e) {
      log('Home repo error: $e');
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
                  : null) ??
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
        return _t('Server Failed Connection, Try again');
      default:
        return _t('Network error occurred');
    }
  }
}
