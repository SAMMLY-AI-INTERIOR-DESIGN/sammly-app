import 'dart:convert';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:sammly/core/networking/api_constants.dart';
import 'package:sammly/core/networking/dio_helper.dart';
import 'package:sammly/core/shared_pref/shared_pref.dart';
import 'package:sammly/features/profile/data/models/profile_model.dart';

class ProfileRepo {
  static const String _profileCacheKey = 'cached_profile_data';

  Future<Either<String, ProfileModel>> getProfile({bool forceRefresh = false}) async {
    try {
      if (!forceRefresh) {
        final cachedData = SharedPref.getData(key: _profileCacheKey);
        if (cachedData != null && cachedData.isNotEmpty) {
          final Map<String, dynamic> jsonMap = jsonDecode(cachedData);
          return right(ProfileModel.fromJson(jsonMap));
        }
      }

      final token = SharedPref.getData(key: 'jwt');
      if (token == null) {
        return left('Unauthorized: No token found.');
      }

      final response = await DioHelper.getData(
        endPoint: ApiConstants.getProfile,
        token: token,
      );

      if (response.statusCode == 200 && response.data['status'] == 'success') {
        final userMap = response.data['data']['profile'] as Map<String, dynamic>;
        log(userMap.toString());
        await SharedPref.saveData(
          key: _profileCacheKey,
          value: jsonEncode(userMap),
        );

        return right(ProfileModel.fromJson(userMap));
      } else {
        log(response.data.toString());
        return left(response.data['message'] ?? 'Failed to get profile data.');
      }
    } on DioException catch (e) {
      return left(_handleDioError(e));
    } catch (e) {
      return left('An unexpected error occurred.');
    }
  }

  Future<Either<String, ProfileModel>> editProfile(Map<String, dynamic> data) async {
    try {
      final token = SharedPref.getData(key: 'jwt');
      if (token == null) {
        return left('Unauthorized: No token found.');
      }

      final response = await DioHelper.patchData(
        endPoint: ApiConstants.editProfile,
        data: data,
        token: token,
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        final userMap = response.data['user'] as Map<String, dynamic>;
        
        await SharedPref.saveData(
          key: _profileCacheKey,
          value: jsonEncode(userMap),
        );

        return right(ProfileModel.fromJson(userMap));
      } else {
        return left(response.data['message'] ?? 'Failed to update profile.');
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
          final msg = data['message'] ?? data['msg'] ?? (data['data'] is Map ? (data['data']['msg'] ?? data['data']['message']) : null);
          if (msg != null) return msg.toString();
        }
      } catch (_) {}
    }
    
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Connection timed out';
      case DioExceptionType.connectionError:
        return 'No internet connection';
      default:
        return 'Network error occurred';
    }
  }
}
