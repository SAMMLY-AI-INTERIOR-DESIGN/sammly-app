import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:sammly/core/networking/api_constants.dart';
import 'package:sammly/core/networking/dio_helper.dart';
import 'package:sammly/core/shared_pref/shared_pref.dart';
import 'package:sammly/features/favorite/data/models/favorite_response_model.dart';

class FavoriteRepo {

  Future<Either<String, FavoriteResponseModel>> getFavorites({
    required int page,
    int limit = 20,
    String style = 'all',
  }) async {
    try {
      final token = SharedPref.getData(key: 'jwt');

      final Map<String, dynamic> queryParams = {
        'page': page,
        'limit': limit,
        'style': style,
      };

      final response = await DioHelper.getData(
        endPoint: ApiConstants.getFavorites,
        queryParameters: queryParams,
        token: token,
      );

      if (response.statusCode == 200 &&
          response.data['status'] == 'success') {
        final dataJson = response.data['data'];
        if (dataJson != null && dataJson is Map<String, dynamic>) {
          final model = FavoriteResponseModel.fromJson(dataJson);
          return right(model);
        }
        return left('Unexpected response format.');
      } else {
        final msg =
            response.data['message']?.toString() ?? 'Failed to load favorites.';
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
