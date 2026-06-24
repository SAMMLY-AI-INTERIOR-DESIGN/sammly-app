import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:crop_your_image/crop_your_image.dart';
import 'package:image/image.dart' as img;
import 'package:sammly/generated/l10n.dart';

class CropImageScreen extends StatefulWidget {
  final String imagePath;
  const CropImageScreen({super.key, required this.imagePath});

  @override
  State<CropImageScreen> createState() => _CropImageScreenState();
}

class _CropImageScreenState extends State<CropImageScreen> {
  final _controller = CropController();
  Uint8List? _imageData;
  bool _isCropping = false;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  Future<void> _loadImage() async {
    final bytes = await File(widget.imagePath).readAsBytes();
    if (mounted) setState(() => _imageData = bytes);
  }

  Future<void> _onCropped(CropResult result) async {
    switch (result) {
      case CropSuccess(:final croppedImage):
        final parentDir = File(widget.imagePath).parent;
        final file = File(
          '${parentDir.path}/cropped_${DateTime.now().millisecondsSinceEpoch}.jpg',
        );

        // Compress and resize the cropped image using the image package
        Uint8List finalBytes = croppedImage;
        try {
          final decoded = img.decodeImage(croppedImage);
          if (decoded != null) {
            img.Image resized = decoded;
            if (decoded.width > 800 || decoded.height > 800) {
              resized = img.copyResize(decoded, width: 800, height: 800);
            }
            finalBytes = Uint8List.fromList(img.encodeJpg(resized, quality: 50));
          }
        } catch (e) {
          debugPrint("Failed to compress cropped image: $e");
        }

        await file.writeAsBytes(finalBytes);
        if (mounted) Navigator.pop(context, file);
      case CropFailure():
        setState(() => _isCropping = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context, null),
        ),
        title: Text(
          S.of(context).cropImage,
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.check, color: Colors.white),
            onPressed: _isCropping
                ? null
                : () {
                    setState(() => _isCropping = true);
                    _controller.crop();
                  },
          ),
        ],
      ),
      body: _imageData == null
          ? const Center(child: CircularProgressIndicator(color: Colors.white))
          : Center(
              child: Crop(
                image: _imageData!,
                controller: _controller,
                onCropped: _onCropped,
                aspectRatio: 1,
                withCircleUi: true,
                baseColor: Colors.black,
                maskColor: Colors.black.withValues(alpha: 0.7),
                interactive: true,
                progressIndicator: const CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ),
    );
  }
}
