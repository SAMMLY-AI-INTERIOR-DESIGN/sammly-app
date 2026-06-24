import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:sammly/core/networking/api_constants.dart';
import 'package:sammly/core/networking/dio_helper.dart';
import 'package:sammly/core/shared_pref/shared_pref.dart';
import 'package:sammly/core/utils/backend_message_translator.dart';
import 'package:sammly/features/generate/data/model/generate_design_response_model.dart';
import 'package:sammly/core/networking/cloudinary_service.dart';

class GenerateDesignRepo {
  static String _t(String msg) => BackendMessageTranslator.translate(msg);

  Future<String?> _prepareImageUrl(String? imageUrl) async {
    if (imageUrl == null || imageUrl.isEmpty) return null;
    if (imageUrl.startsWith('http://') ||
        imageUrl.startsWith('https://') ||
        imageUrl.startsWith('data:')) {
      return imageUrl;
    }

    try {
      String cleanPath = imageUrl;
      if (cleanPath.startsWith('file://')) {
        cleanPath = Uri.parse(cleanPath).toFilePath();
      }
      final file = File(cleanPath);
      if (await file.exists()) {
        final cloudinaryUrl = await CloudinaryService.uploadImage(file);
        if (cloudinaryUrl != null) {
          return cloudinaryUrl;
        }
        
        // Fallback to base64 if Cloudinary upload fails, though ideally
        // we should probably just throw an error here.
        final bytes = await file.readAsBytes();
        final base64Image = base64Encode(bytes);
        final ext = file.path.split('.').last.toLowerCase();
        final mimeType = (ext == 'jpg' || ext == 'jpeg')
            ? 'image/jpeg'
            : 'image/png';
        return 'data:$mimeType;base64,$base64Image';
      }
    } catch (e) {
      log("Error processing image: $e");
    }
    return imageUrl;
  }

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
        'room_type': room,
        'prompt': prompt,
      };

      final processedImageUrl = await _prepareImageUrl(imageUrl);
      if (processedImageUrl != null && processedImageUrl.isNotEmpty) {
        requestData['image_url'] = processedImageUrl;
      }

      final response = await DioHelper.postData(
        endPoint: ApiConstants.generateDesign,
        data: requestData,
        token: token,
      );
      log(response.statusCode.toString());
      if (response.statusCode == 201 || response.data['status'] == 'success') {
        final dataMap = response.data['data'] as Map<String, dynamic>?;
        final designJson = dataMap?['design'];

        if (designJson != null && designJson is Map<String, dynamic>) {
          // Aggressively extract the ID from various possible locations in the response
          final extractedId =
              designJson['_id']?.toString() ??
              designJson['id']?.toString() ??
              designJson['designId']?.toString() ??
              designJson['design_id']?.toString() ??
              dataMap?['_id']?.toString() ??
              dataMap?['id']?.toString() ??
              dataMap?['designId']?.toString() ??
              dataMap?['design_id']?.toString() ??
              response.data['_id']?.toString() ??
              response.data['id']?.toString() ??
              response.data['designId']?.toString() ??
              response.data['design_id']?.toString() ??
              '';

          if (extractedId.isEmpty) {
            log(
              'WARNING: Could not find any ID field in generation response! Data: ${response.data}',
            );
          }

          // Inject the extracted ID into designJson so the model parses it
          designJson['_id'] = extractedId;

          final model = GenerateDesignResponseModel.fromJson(designJson);
          return right(model);
        }
        return left(_t('Unexpected response format.'));
      } else {
        final msg =
            response.data['message']?.toString() ?? 'Generation failed.';
        return left(_t(msg));
      }
    } on DioException catch (e) {
      return left(_handleDioError(e));
    } catch (e) {
      return left(_t('An unexpected error occurred.'));
    }
  }

  String _handleDioError(DioException e) {
    if (e.response != null && e.response?.data != null) {
      try {
        final data = e.response!.data;
        if (data is Map) {
          final msg = data['message'] ?? data['msg'];
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
      case DioExceptionType.badResponse:
        return _t('Bad response: ${e.response?.statusCode} - ${e.message}');
      default:
        return _t('Error: ${e.message ?? e.error ?? 'Something went wrong.'}');
    }
  }

  Future<Either<String, GenerateDesignResponseModel>> restyleDesign({
    required String style,
    required String imageUrl,
  }) async {
    try {
      final token = SharedPref.getData(key: 'jwt');

      final processedImageUrl = await _prepareImageUrl(imageUrl);

      final Map<String, dynamic> requestData = {
        'style': style,
        'image_url': processedImageUrl,
      };

      final response = await DioHelper.postData(
        endPoint: ApiConstants.restyleDesign,
        data: requestData,
        token: token,
      );
      log(response.statusCode.toString());
      if (response.statusCode == 201 || response.data['status'] == 'success') {
        final dataMap = response.data['data'] as Map<String, dynamic>?;
        final designJson = dataMap?['design'];

        if (designJson != null && designJson is Map<String, dynamic>) {
          final extractedId =
              designJson['_id']?.toString() ??
              designJson['id']?.toString() ??
              designJson['designId']?.toString() ??
              designJson['design_id']?.toString() ??
              dataMap?['_id']?.toString() ??
              dataMap?['id']?.toString() ??
              dataMap?['designId']?.toString() ??
              dataMap?['design_id']?.toString() ??
              response.data['_id']?.toString() ??
              response.data['id']?.toString() ??
              response.data['designId']?.toString() ??
              response.data['design_id']?.toString() ??
              '';

          if (extractedId.isEmpty) {
            log(
              'WARNING: Could not find any ID field in generation response! Data: ${response.data}',
            );
          }

          designJson['_id'] = extractedId;

          final model = GenerateDesignResponseModel.fromJson(designJson);
          return right(model);
        }
        return left(_t('Unexpected response format.'));
      } else {
        final msg = response.data['message']?.toString() ?? 'Restyle failed.';
        return left(_t(msg));
      }
    } on DioException catch (e) {
      return left(_handleDioError(e));
    } catch (e) {
      return left(_t('An unexpected error occurred.'));
    }
  }

  Future<Either<String, List<GenerateDesignResponseModel>>>
  generateFullHomeDesign({
    required String style,
    required List<String> roomTypes,
    String? styleImageUrl,
  }) async {
    try {
      final token = SharedPref.getData(key: 'jwt');

      final Map<String, dynamic> requestData = {
        'style': style,
        'room_types': roomTypes,
      };

      final processedImageUrl = await _prepareImageUrl(styleImageUrl);
      if (processedImageUrl != null && processedImageUrl.isNotEmpty) {
        requestData['style_image_url'] = processedImageUrl;
        requestData['styleImageUrl'] = processedImageUrl;
      }

      final response = await DioHelper.postData(
        endPoint: ApiConstants.fullHomeDesign,
        data: requestData,
        token: token,
      );

      log(response.data.toString());
      if (response.statusCode == 201 || response.data['status'] == 'success') {
        final dataMap = response.data['data'] as Map<String, dynamic>?;
        final designsList = dataMap?['designs'] as List<dynamic>?;

        if (designsList != null) {
          List<GenerateDesignResponseModel> models = [];
          for (var designJson in designsList) {
            if (designJson is Map<String, dynamic>) {
              final extractedId =
                  designJson['_id']?.toString() ??
                  designJson['id']?.toString() ??
                  designJson['designId']?.toString() ??
                  designJson['design_id']?.toString() ??
                  '';

              designJson['_id'] = extractedId;
              models.add(GenerateDesignResponseModel.fromJson(designJson));
            }
          }
          return right(models);
        }
        return left(_t('Unexpected response format.'));
      } else {
        final msg =
            response.data['message']?.toString() ??
            'Full home generation failed.';
        return left(_t(msg));
      }
    } on DioException catch (e) {
      return left(_handleDioError(e));
    } catch (e) {
      return left(_t('An unexpected error occurred.'));
    }
  }

  Future<Either<String, GenerateDesignResponseModel>> generateMaskDesign({
    required String imageUrl,
    required String maskUrl,
    String? prompt,
    required String operationMode,
  }) async {
    try {
      final token = SharedPref.getData(key: 'jwt');

      final processedImageUrl = await _prepareImageUrl(imageUrl);
      final processedMaskUrl = await _prepareImageUrl(maskUrl);

      final Map<String, dynamic> requestData = {
        'image_url': processedImageUrl,
        'mask_url': processedMaskUrl,
        'operation_mode': operationMode,
        'imageUrl': processedImageUrl,
        'maskUrl': processedMaskUrl,
        'operationMode': operationMode,
      };

      if (prompt != null && prompt.isNotEmpty) {
        requestData['prompt'] = prompt;
      }

      final response = await DioHelper.postData(
        endPoint: ApiConstants.maskDesign,
        data: requestData,
        token: token,
      );

      log(response.data.toString());
      if (response.statusCode == 201 || response.data['status'] == 'success') {
        final dataMap = response.data['data'] as Map<String, dynamic>?;
        final designJson = dataMap?['design'] as Map<String, dynamic>?;

        if (designJson != null) {
          final extractedId =
              designJson['_id']?.toString() ??
              designJson['id']?.toString() ??
              designJson['designId']?.toString() ??
              designJson['design_id']?.toString() ??
              '';

          designJson['_id'] = extractedId;
          final model = GenerateDesignResponseModel.fromJson(designJson);
          return right(model);
        }
        return left(_t('Unexpected response format.'));
      } else {
        final msg =
            response.data['message']?.toString() ?? 'Mask design failed.';
        return left(_t(msg));
      }
    } on DioException catch (e) {
      return left(_handleDioError(e));
    } catch (e) {
      return left(_t('An unexpected error occurred.'));
    }
  }
}
