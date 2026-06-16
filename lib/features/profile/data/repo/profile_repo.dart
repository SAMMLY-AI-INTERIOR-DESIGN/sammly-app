import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:sammly/core/networking/api_constants.dart';
import 'package:sammly/core/networking/dio_helper.dart';
import 'package:sammly/core/shared_pref/shared_pref.dart';
import 'package:sammly/features/profile/data/models/profile_model.dart';
import 'package:sammly/features/profile/data/models/setting_info_model.dart';

class ProfileRepo {
  // static const String _profileCacheKey = 'cached_profile_data';

  Future<Either<String, ProfileModel>> getProfile({
    bool forceRefresh = false,
  }) async {
    try {
      // 1. نجيب التوكن الأول عشان لو مش موجود نخرج بدري
      final token = SharedPref.getData(key: 'jwt');
      if (token == null) {
        return left('Unauthorized: No token found.');
      }

      // 2. نجيب الـ userId بتاع اليوزر الحالي (لازم تكون مسيفه وقت الـ Login)
      // لو مش متسيف، بنعمل fallback بأي قيمة أو بالتوكن عشان الكاش ميتداخلش
      final currentUserId =
          SharedPref.getData(key: 'userId') ?? token.hashCode.toString();

      // 3. نعمل الـ Key ديناميك لكل يوزر
      final String dynamicProfileCacheKey =
          'cached_profile_data_$currentUserId';

      // 4. نقرأ من الكاش المربوط باليوزر ده بس
      // if (!forceRefresh) {
      //   final cachedData = SharedPref.getData(key: dynamicProfileCacheKey);
      //   if (cachedData != null && cachedData.isNotEmpty) {
      //     final Map<String, dynamic> jsonMap = jsonDecode(cachedData);
      //     return right(ProfileModel.fromJson(jsonMap));
      //   }
      // }

      // 5. لو مفيش كاش أو عاملين forceRefresh، نكلم الـ API
      final response = await DioHelper.getData(
        endPoint: ApiConstants.getProfile,
        token: token,
      );
      log('Profile Data: ${response.data.toString()}');
      if (response.statusCode == 200 && response.data['status'] == 'success') {
        final userMap =
            response.data['data']['profile'] as Map<String, dynamic>;
        // log(userMap.toString());

        // 6. نسيف الداتا في الكاش المخصص لليوزر ده
        await SharedPref.saveData(
          key: dynamicProfileCacheKey,
          value: jsonEncode(userMap),
        );

        // خطوة تأكيدية: لو مكنتش بتسيف الـ userId وقت اللوجين، احفظه من هنا للمرات الجاية
        if (SharedPref.getData(key: 'userId') == null) {
          final idToSave = userMap['userId'] ?? userMap['id'] ?? userMap['_id'];
          if (idToSave != null) {
            await SharedPref.saveData(
              key: 'userId',
              value: idToSave.toString(),
            );
          }
        }

        return right(ProfileModel.fromJson(userMap));
      } else {
        // log(response.data.toString());
        return left(response.data['message'] ?? 'Failed to get profile data.');
      }
    } on DioException catch (e) {
      return left(_handleDioError(e));
    } catch (e) {
      return left('An unexpected error occurred.');
    }
  }

  Future<Either<String, ProfileModel>> editProfile(
    Map<String, dynamic> data, {
    File? imageFile,
  }) async {
    try {
      final token = SharedPref.getData(key: 'jwt');
      if (token == null) {
        return left('Unauthorized: No token found.');
      }

      // لو اليوزر اختار صورة، نحولها لـ base64 ونضيفها كـ string في الـ JSON
      if (imageFile != null) {
        final bytes = await imageFile.readAsBytes();
        final base64Image = base64Encode(bytes);
        // نحدد الـ extension عشان الـ data URI
        final ext = imageFile.path.split('.').last.toLowerCase();
        final mimeType = ext == 'png' ? 'image/png' : 'image/jpeg';
        data['avatar'] = 'data:$mimeType;base64,$base64Image';
      }

      final response = await DioHelper.patchData(
        endPoint: ApiConstants.editProfile,
        data: data,
        token: token,
      );
      log(response.data.toString());
      if (response.statusCode == 200 && response.data['status'] == 'success') {
        final userMap =
            response.data['data']['profile'] as Map<String, dynamic>;

        // 1. نجيب الـ userId بتاع اليوزر الحالي زي ما عملنا في getProfile
        final currentUserId =
            SharedPref.getData(key: 'userId') ?? token.hashCode.toString();

        // 2. نعمل الـ Key ديناميك الخاص باليوزر ده
        final String dynamicProfileCacheKey =
            'cached_profile_data_$currentUserId';

        // 3. نحدث الكاش الخاص باليوزر ده بالداتا الجديدة بعد التعديل
        await SharedPref.saveData(
          key: dynamicProfileCacheKey,
          value: jsonEncode(userMap),
        );
        log(response.data['data']['profile']['avatar'].toString());
        return right(ProfileModel.fromJson(userMap));
      } else {
        return left(response.data['message'] ?? 'Failed to update profile.');
      }
    } on DioException catch (e) {
      return left(_handleDioError(e));
    } catch (e) {
      log('Edit profile error: $e');
      return left('An unexpected error occurred.');
    }
  }

  Future<Either<String, SettingInfoModel>> getSettingInfo() async {
    try {
      final token = SharedPref.getData(key: 'jwt');
      if (token == null) {
        return left('Unauthorized: No token found.');
      }

      final response = await DioHelper.getData(
        endPoint: ApiConstants.settingsEndpoint,
        token: token,
      );

      if (response.statusCode == 200 && response.data['status'] == 'success') {
        final dataMap = response.data['data'] as Map<String, dynamic>;
        return right(SettingInfoModel.fromJson(dataMap));
      } else {
        return left(response.data['message'] ?? 'Failed to get settings data.');
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
        log('API Error Response: $data');
        if (data is Map) {
          // الـ API ممكن يرجع الـ error message في أماكن مختلفة
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
