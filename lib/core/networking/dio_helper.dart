import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:sammly/core/networking/api_constants.dart';
import 'package:sammly/main.dart';
import 'package:sammly/core/widgets/no_internet_view.dart';
import 'package:sammly/core/routing/routes.dart';
import 'package:sammly/core/shared_pref/shared_pref.dart';

abstract class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    dio.interceptors.add(InterceptorsWrapper(
      onError: (DioException e, handler) async {
        // If the request fails, only show No Internet View if we ACTUALLY have no signal.
        if (e.type == DioExceptionType.connectionTimeout ||
            e.type == DioExceptionType.sendTimeout ||
            e.type == DioExceptionType.receiveTimeout ||
            e.type == DioExceptionType.connectionError) {
          
          // Double check internet access
          bool hasInternet = await InternetConnection().hasInternetAccess;
          
          if (!hasInternet) {
            final BuildContext? context = navigatorKey.currentContext;
            if (context != null) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NoInternetView()),
              );
            }
          }
        }

        // Handle 401 Unauthorized (Session Expired)
        if (e.response?.statusCode == 401) {
          final BuildContext? context = navigatorKey.currentContext;
          if (context != null) {
            // Clear user data
            await SharedPref.clearAll();
            
            // Show message
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("You logged in with another device. Please log in again."),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
              ),
            );

            // Redirect to login
            Navigator.of(context).pushNamedAndRemoveUntil(
              AppRoutes.loginView,
              (route) => false,
            );
          }
        }
        return handler.next(e);
      },
    ));
  }

  static bool _shouldRetry(DioException e) {
    return e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.sendTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.connectionError;
  }

  static Future<Response> getData({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    String? token,
  }) async {
    dio.options.headers['Authorization'] = token != null ? 'Bearer $token' : '';
    
    int retries = 2; // Check again and again (retry twice)
    while (true) {
      try {
        return await dio.get(
          endPoint,
          queryParameters: queryParameters,
        );
      } catch (e) {
        if (retries == 0) rethrow;
        if (e is DioException && _shouldRetry(e)) {
          retries--;
          await Future.delayed(const Duration(milliseconds: 1500));
          continue;
        }
        rethrow;
      }
    }
  }

  static Future<Response> postData({
    required String endPoint,
    required dynamic data,
    Map<String, dynamic>? queryParameters,
    String? token,
  }) async {
    dio.options.headers['Authorization'] = token != null ? 'Bearer $token' : '';

    int retries = 2;
    while (true) {
      try {
        return await dio.post(
          endPoint,
          data: data,
          queryParameters: queryParameters,
        );
      } catch (e) {
        if (retries == 0) rethrow;
        if (e is DioException && _shouldRetry(e)) {
          retries--;
          await Future.delayed(const Duration(milliseconds: 1500));
          continue;
        }
        rethrow;
      }
    }
  }

  static Future<Response> patchData({
    required String endPoint,
    required dynamic data,
    Map<String, dynamic>? queryParameters,
    String? token,
  }) async {
    dio.options.headers['Authorization'] = token != null ? 'Bearer $token' : '';

    int retries = 2;
    while (true) {
      try {
        return await dio.patch(
          endPoint,
          data: data,
          queryParameters: queryParameters,
        );
      } catch (e) {
        if (retries == 0) rethrow;
        if (e is DioException && _shouldRetry(e)) {
          retries--;
          await Future.delayed(const Duration(milliseconds: 1500));
          continue;
        }
        rethrow;
      }
    }
  }

  static Future<Response> deleteData({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    String? token,
  }) async {
    dio.options.headers['Authorization'] = token != null ? 'Bearer $token' : '';

    int retries = 2;
    while (true) {
      try {
        return await dio.delete(
          endPoint,
          queryParameters: queryParameters,
        );
      } catch (e) {
        if (retries == 0) rethrow;
        if (e is DioException && _shouldRetry(e)) {
          retries--;
          await Future.delayed(const Duration(milliseconds: 1500));
          continue;
        }
        rethrow;
      }
    }
  }
}