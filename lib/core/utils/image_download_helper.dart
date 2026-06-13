import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:sammly/core/constant/app_colors.dart';

/// Helper class for downloading images to device gallery
class ImageDownloadHelper {
  /// Downloads a network image and saves it to the device gallery
  static Future<void> downloadNetworkImage(
    BuildContext context,
    String imageUrl,
  ) async {
    try {
      // Show loading snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 12),
              Text('Downloading image...'),
            ],
          ),
          duration: Duration(seconds: 10),
          backgroundColor: AppColors.primaryColor,
        ),
      );

      // Download image bytes
      final response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode != 200) {
        throw Exception('Failed to download image');
      }

      // Save to gallery
      final result = await ImageGallerySaverPlus.saveImage(
        Uint8List.fromList(response.bodyBytes),
        quality: 100,
        name: "sammly_${DateTime.now().millisecondsSinceEpoch}",
      );

      if (!context.mounted) return;
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      if (result != null && result['isSuccess'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Image saved to gallery successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        throw Exception('Failed to save image');
      }
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error saving image: $e'),
          backgroundColor: AppColors.redColor,
        ),
      );
    }
  }

  /// Saves a local file (e.g. mask) to the device gallery
  static Future<void> saveLocalImage(
    BuildContext context,
    String filePath,
  ) async {
    try {
      final result = await ImageGallerySaverPlus.saveFile(filePath);

      if (!context.mounted) return;

      if (result != null && result['isSuccess'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Image saved to gallery successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        throw Exception('Failed to save image');
      }
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error saving image: $e'),
          backgroundColor: AppColors.redColor,
        ),
      );
    }
  }

  /// Saves raw bytes to the device gallery
  static Future<void> saveBytesToGallery(
    BuildContext context,
    Uint8List bytes,
  ) async {
    try {
      final result = await ImageGallerySaverPlus.saveImage(
        bytes,
        quality: 100,
        name: "sammly_${DateTime.now().millisecondsSinceEpoch}",
      );

      if (!context.mounted) return;

      if (result != null && result['isSuccess'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Image saved to gallery successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        throw Exception('Failed to save image');
      }
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error saving image: $e'),
          backgroundColor: AppColors.redColor,
        ),
      );
    }
  }
}
