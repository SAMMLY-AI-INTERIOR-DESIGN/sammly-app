
import 'package:dio/dio.dart';
import 'package:sammly/core/networking/api_constants.dart';

abstract class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
        // Adding default headers for JSON communication
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
  }

  static Future<Response> getData({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    String? token,
  }) async {
    dio.options.headers['Authorization'] = token != null ? 'Bearer $token' : '';
    
    return await dio.get(
      endPoint,
      queryParameters: queryParameters,
    );
  }

  static Future<Response> postData({
    required String endPoint,
    required dynamic data,
    Map<String, dynamic>? queryParameters,
    String? token,
  }) async {
    dio.options.headers['Authorization'] = token != null ? 'Bearer $token' : '';

    return await dio.post(
      endPoint,
      data: data,
      queryParameters: queryParameters,
    );
  }

  static Future<Response> patchData({
    required String endPoint,
    required dynamic data,
    Map<String, dynamic>? queryParameters,
    String? token,
  }) async {
    dio.options.headers['Authorization'] = token != null ? 'Bearer $token' : '';

    return await dio.patch(
      endPoint,
      data: data,
      queryParameters: queryParameters,
    );
  }
}