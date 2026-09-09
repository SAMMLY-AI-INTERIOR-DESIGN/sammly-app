import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

class CloudinaryService {
  static String get cloudName => dotenv.env['CLOUDINARY_CLOUD_NAME']!;
  static String get apiKey => dotenv.env['CLOUDINARY_API_KEY']!;
  static String get apiSecret => dotenv.env['CLOUDINARY_API_SECRET']!;

  /// Uploads an image file directly to Cloudinary using a signed request
  /// and returns the secure URL of the uploaded image.
  static Future<String?> uploadImage(File file) async {
    try {
      final timestamp = (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();

      // Cloudinary signature requires parameters to be alphabetically sorted
      // We only have timestamp here. Then append the apiSecret.
      final strToSign = 'timestamp=$timestamp$apiSecret';
      
      // Generate SHA-1 signature
      final bytes = utf8.encode(strToSign);
      final signature = sha1.convert(bytes).toString();

      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(file.path),
        'api_key': apiKey,
        'timestamp': timestamp,
        'signature': signature,
      });

      final dio = Dio();
      final response = await dio.post(
        'https://api.cloudinary.com/v1_1/$cloudName/image/upload',
        data: formData,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data['secure_url'];
      }
      
      log('Cloudinary Upload Failed: ${response.data}');
      return null;
    } catch (e) {
      log('Cloudinary Upload Error: $e');
      return null;
    }
  }

  /// Uploads an image path (local file or base64 data URI) to Cloudinary
  /// and returns the secure Cloudinary HTTP URL.
  /// If input is already an http/https URL, returns it directly.
  static Future<String?> uploadImagePathOrData(String input) async {
    if (input.trim().isEmpty) return null;

    if (input.startsWith('http://') || input.startsWith('https://')) {
      return input;
    }

    try {
      // Check if it's a local file path
      String cleanPath = input;
      if (cleanPath.startsWith('file://')) {
        cleanPath = Uri.parse(cleanPath).toFilePath();
      }
      final file = File(cleanPath);
      if (await file.exists()) {
        return await uploadImage(file);
      }

      // If it's a base64 data URI or raw base64 string
      if (input.startsWith('data:') || input.length > 100) {
        final timestamp = (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();
        final strToSign = 'timestamp=$timestamp$apiSecret';
        final bytes = utf8.encode(strToSign);
        final signature = sha1.convert(bytes).toString();

        final formData = FormData.fromMap({
          'file': input,
          'api_key': apiKey,
          'timestamp': timestamp,
          'signature': signature,
        });

        final dio = Dio();
        final response = await dio.post(
          'https://api.cloudinary.com/v1_1/$cloudName/image/upload',
          data: formData,
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          return response.data['secure_url'];
        }
        log('Cloudinary base64 Upload Failed: ${response.data}');
      }
    } catch (e) {
      log('Cloudinary Upload Error: $e');
    }
    return null;
  }
}
