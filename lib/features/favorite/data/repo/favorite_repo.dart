import 'dart:convert';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:sammly/core/networking/api_constants.dart';
import 'package:sammly/core/networking/dio_helper.dart';
import 'package:sammly/core/shared_pref/shared_pref.dart';
import 'package:sammly/features/favorite/data/models/favorite_item_model.dart';

class FavoriteRepo {
  Future<Either<String, FavoriteResponse>> getFavorites({
    int page = 1,
    int limit = 20,
    String room = 'all',
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

      final Map<String, dynamic> queryParams = {'page': page, 'limit': limit};
      final cleanRoom = room.toLowerCase().replaceAll(' ', '');
      if (cleanRoom != 'all') {
        queryParams['room'] = cleanRoom;
      }

      final response = await DioHelper.getData(
        endPoint: ApiConstants.favorites,
        queryParameters: queryParams,
        token: token,
      );

      if (response.statusCode == 200 && response.data['status'] == 'success') {
        final data = response.data['data'] as Map<String, dynamic>;
        return right(FavoriteResponse.fromJson(data));
      } else {
        log(response.data.toString());
        final backendError = _extractErrorMessage(response.data);
        return left(
          backendError.isNotEmpty ? backendError : 'Failed to load favorites.',
        );
      }
    } on DioException catch (e) {
      return left(_handleDioError(e));
    } catch (e) {
      log('Favorites error: $e');
      return left('An unexpected error occurred.');
    }
  }

  Future<Either<String, String>> addToFavorite(String designId) async {
    try {
      final token = SharedPref.getData(key: 'jwt');
      if (token == null) {
        return left('Unauthorized: No token found.');
      }

      // Add to favorites: POST, returns 201
      final endpoint = ApiConstants.favoriteDesign(designId);
      log('Add favorite → endpoint: $endpoint, designId: $designId');

      // Use validateStatus to accept all status codes (201, 404, 409)
      // so Dio doesn't throw DioException for expected error responses
      DioHelper.dio.options.headers['Authorization'] = 'Bearer $token';
      final response = await DioHelper.dio.post(
        endpoint,
        options: Options(
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      final isMap = response.data is Map;

      if (response.statusCode == 201 &&
          isMap &&
          response.data['status'] == 'success') {
        final msg =
            response.data['data']?['message'] ??
            response.data['message'] ??
            'Added to favorites.';
        return right(msg);
      } else {
        // Handle 404 (Design not found) and 409 (Already in favorites)
        final backendError = _extractErrorMessage(response.data);
        return left(
          backendError.isNotEmpty
              ? backendError
              : 'Failed to add to favorites.',
        );
      }
    } on DioException catch (e) {
      return left(_handleDioError(e));
    } catch (e) {
      log('Add favorite error: $e');
      return left('An unexpected error occurred.');
    }
  }

  Future<Either<String, String>> removeFromFavorite(String designId) async {
    try {
      final token = SharedPref.getData(key: 'jwt');
      if (token == null) {
        return left('Unauthorized: No token found.');
      }

      // API spec: remove from favorites uses DELETE method, returns 200
      DioHelper.dio.options.headers['Authorization'] = 'Bearer $token';
      final response = await DioHelper.dio.delete(
        ApiConstants.favoriteDesign(designId),
        options: Options(
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      final isMap = response.data is Map;

      if (response.statusCode == 200 &&
          isMap &&
          response.data['status'] == 'success') {
        final msg =
            response.data['data']?['message'] ??
            response.data['message'] ??
            'Removed from favorites.';
        return right(msg);
      } else {
        final backendError = _extractErrorMessage(response.data);
        return left(
          backendError.isNotEmpty
              ? backendError
              : 'Failed to remove from favorites.',
        );
      }
    } on DioException catch (e) {
      return left(_handleDioError(e));
    } catch (e) {
      log('Remove favorite error: $e');
      return left('An unexpected error occurred.');
    }
  }

  String _extractErrorMessage(dynamic responseData) {
    try {
      var data = responseData;
      if (data is String) {
        try {
          data = jsonDecode(data);
        } catch (_) {}
      }
      if (data is Map) {
        final msg =
            data['message'] ??
            data['msg'] ??
            data['error'] ??
            (data['data'] is Map
                ? (data['data']['msg'] ?? data['data']['message'])
                : null) ??
            (data['errors'] is List
                ? (data['errors'] as List).join(', ')
                : data['errors']);
        if (msg != null && msg.toString().isNotEmpty) {
          return msg.toString();
        }
      }
    } catch (_) {}
    return '';
  }

  String _handleDioError(DioException e) {
    if (e.response != null && e.response?.data != null) {
      final msg = _extractErrorMessage(e.response!.data);
      if (msg.isNotEmpty) return msg;
    }

    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return 'Server Failed Connection , Try again';
      case DioExceptionType.badResponse:
        return 'Bad response: ${e.response?.statusCode} - ${e.response?.statusMessage ?? 'Error'}';
      default:
        return 'Network error occurred';
    }
  }
}
