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

      final Map<String, dynamic> queryParams = {
        'page': page,
        'limit': limit,
      };
      if (room != 'all') {
        queryParams['room'] = room;
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
        return left(response.data['message'] ?? 'Failed to load favorites.');
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

      final response = await DioHelper.postData(
        endPoint: ApiConstants.favoriteDesign(designId),
        data: {},
        token: token,
      );

      if (response.statusCode == 200 && response.data['status'] == 'success') {
        return right(response.data['message'] ?? 'Added to favorites.');
      } else {
        return left(response.data['message'] ?? 'Failed to add to favorites.');
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

      final response = await DioHelper.deleteData(
        endPoint: ApiConstants.favoriteDesign(designId),
        token: token,
      );

      if (response.statusCode == 200 && response.data['status'] == 'success') {
        return right(response.data['message'] ?? 'Removed from favorites.');
      } else {
        return left(response.data['message'] ?? 'Failed to remove from favorites.');
      }
    } on DioException catch (e) {
      return left(_handleDioError(e));
    } catch (e) {
      log('Remove favorite error: $e');
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
