import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:sammly/core/networking/api_constants.dart';
import 'package:sammly/core/networking/dio_helper.dart';
import 'package:sammly/core/shared_pref/shared_pref.dart';
import 'package:sammly/features/generate/data/model/generate_design_response_model.dart';

class GenerateDesignRepo {
  /// POST /api/designs
  /// Returns [Right(GenerateDesignResponseModel)] on success,
  /// or [Left(errorMessage)] on failure.
  Future<Either<String, GenerateDesignResponseModel>> generateDesign({
    required String style,
    required String room,
    required String prompt,
    String? imageUrl,
  }) async {
    try {
      final token = SharedPref.getData(key: 'jwt');

      final Map<String, dynamic> requestData = {
        'style': style,
        'room': room,
        'prompt': prompt,
      };

      if (imageUrl != null && imageUrl.isNotEmpty) {
        requestData['imageUrl'] = imageUrl;
      }

      final response = await DioHelper.postData(
        endPoint: ApiConstants.generateDesign,
        data: requestData,
        token: token,
      );
      log(response.statusCode.toString());
      if (response.statusCode == 201 ||
          response.data['status'] == 'success') {
        final designJson = response.data['data']?['design'];
        if (designJson != null && designJson is Map<String, dynamic>) {
          final model = GenerateDesignResponseModel.fromJson(designJson);
          return right(model);
        }
        return left('Unexpected response format.');
      } else {
        final msg = response.data['message']?.toString() ?? 'Generation failed.';
        return left(msg);
      }
    } on DioException catch (e) {
      return left(_handleDioError(e));
    } catch (e) {
      return left('An unexpected error occurred.');
    }
  }

  String _handleDioError(DioException e) {
    if (e.response != null && e.response?.data != null) {
      try {
        final data = e.response!.data;
        if (data is Map) {
          final msg = data['message'] ?? data['msg'];
          if (msg != null) return msg.toString();
        }
      } catch (_) {}
    }

    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return 'Server Failed Connection, Try again';
      case DioExceptionType.badResponse:
        return 'Bad response: ${e.response?.statusCode} - ${e.message}';
      default:
        return 'Error: ${e.message ?? e.error ?? 'Something went wrong.'}';
    }
  }
}
