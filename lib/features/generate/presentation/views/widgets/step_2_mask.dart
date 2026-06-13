import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_mask_painter/flutter_mask_painter.dart';
import 'package:flutter_mask_painter/mask_painter_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sammly/core/utils/image_download_helper.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/theme/text_styles.dart';
import 'package:sammly/core/widgets/custombutton.dart';

class Step2Mask extends StatefulWidget {
  final XFile uploadedImage;
  final Function(XFile) onNext;
  final String buttonText;

  const Step2Mask({
    super.key,
    required this.uploadedImage,
    required this.onNext,
    this.buttonText = "Next",
  });

  @override
  State<Step2Mask> createState() => _Step2MaskState();
}

class _Step2MaskState extends State<Step2Mask> {
  final MaskPainterController _controller = MaskPainterController();
  final GlobalKey _boundaryKey = GlobalKey();
  bool _isSaving = false;
  double _brushSize = 25.0;

  @override
  void initState() {
    super.initState();
    _controller.setBrushSize(_brushSize);
  }

  Future<ui.Image> _loadImageFromXFile(XFile file) async {
    final Uint8List bytes = await file.readAsBytes();
    final ui.Codec codec = await ui.instantiateImageCodec(bytes);
    final ui.FrameInfo frameInfo = await codec.getNextFrame();
    return frameInfo.image;
  }

  Future<void> _downloadImage() async {
    try {
      if (!mounted) return;

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
              Text('Saving image to gallery...'),
            ],
          ),
          duration: Duration(seconds: 10),
          backgroundColor: AppColors.primaryColor,
        ),
      );

      // 1. Save mask to get the mask file matching original resolution/aspect ratio
      final XFile? maskFile = await _controller.saveMask();
      if (maskFile == null) {
        throw Exception("Failed to save mask layer");
      }

      // 2. Load background and mask images
      final ui.Image bgImage = await _loadImageFromXFile(widget.uploadedImage);
      final ui.Image maskImage = await _loadImageFromXFile(maskFile);

      // 3. Calculate target dimensions to limit max dimension to 1024px
      final double originalWidth = bgImage.width.toDouble();
      final double originalHeight = bgImage.height.toDouble();

      const double maxDimension = 1024.0;
      double scale = 1.0;
      if (originalWidth > maxDimension || originalHeight > maxDimension) {
        if (originalWidth > originalHeight) {
          scale = maxDimension / originalWidth;
        } else {
          scale = maxDimension / originalHeight;
        }
      }

      final double width = originalWidth * scale;
      final double height = originalHeight * scale;
      final ui.Rect rect = ui.Rect.fromLTWH(0, 0, width, height);

      // 4. Create canvas of calculated size
      final ui.PictureRecorder recorder = ui.PictureRecorder();
      final ui.Canvas canvas = ui.Canvas(recorder);

      // Draw background scaled to standard size
      canvas.drawImageRect(
        bgImage,
        ui.Rect.fromLTWH(0, 0, originalWidth, originalHeight),
        rect,
        ui.Paint(),
      );

      // Draw mask with a color filter that makes black transparent and white translucent
      final Paint maskPaint = Paint()
        ..colorFilter = const ColorFilter.matrix(<double>[
          1.0, 0.0, 0.0, 0.0, 0.0, // R' = R
          1.0, 0.0, 0.0, 0.0, 0.0, // G' = R
          1.0, 0.0, 0.0, 0.0, 0.0, // B' = R
          0.85, 0.0, 0.0, 0.0, 0.0, // A' = R * 0.85 (Deep White)
        ]);

      canvas.drawImageRect(
        maskImage,
        ui.Rect.fromLTWH(
          0,
          0,
          maskImage.width.toDouble(),
          maskImage.height.toDouble(),
        ),
        rect,
        maskPaint,
      );

      final ui.Picture picture = recorder.endRecording();
      final ui.Image compositeImage = await picture.toImage(
        width.toInt(),
        height.toInt(),
      );

      final ByteData? byteData = await compositeImage.toByteData(
        format: ui.ImageByteFormat.png,
      );

      if (byteData == null) {
        throw Exception("Failed to convert composite image to bytes");
      }

      final Uint8List pngBytes = byteData.buffer.asUint8List();

      if (!mounted) return;
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      await ImageDownloadHelper.saveBytesToGallery(context, pngBytes);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error saving image: $e'),
          backgroundColor: AppColors.redColor,
        ),
      );
    }
  }

  Future<void> _extractAndProceed() async {
    setState(() {
      _isSaving = true;
    });

    try {
      final XFile? maskFile = await _controller.saveMask();
      if (maskFile != null) {
        widget.onNext(maskFile);
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to extract mask. Please try again.'),
            backgroundColor: AppColors.redColor,
          ),
        );
      }
    } catch (e) {
      debugPrint("Error extracting mask: $e");
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  Widget _buildActionButton(IconData icon, VoidCallback onTap, {Color? color}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: Colors.blue.withOpacity(0.3)),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 2,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Icon(icon, color: color ?? Colors.blue, size: 20.sp),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Text(
            "Draw the Mask",
            style: AppTextStyles.title20SemiBold.copyWith(
              color: AppColors.blackColor,
            ),
          ),
        ),

        Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: AppColors.bg1Color, width: 2),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14.r),
              child: Center(
                child: RepaintBoundary(
                  key: _boundaryKey,
                  child: MaskPainterWidget(
                    backgroundImage: widget.uploadedImage,
                    controller: _controller,
                    showControls: false,
                  ),
                ),
              ),
            ),
          ),
        ),

        // Toolbar Card for Brush Slider
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(Icons.brush, color: AppColors.blackColor, size: 20.sp),
                Expanded(
                  child: Slider(
                    value: _brushSize,
                    min: 5.0,
                    max: 50.0,
                    activeColor: Colors.blue,
                    inactiveColor: Colors.blue.withOpacity(0.3),
                    onChanged: (val) {
                      setState(() {
                        _brushSize = val;
                      });
                      _controller.setBrushSize(val);
                    },
                  ),
                ),
                Container(
                  width: 28.w,
                  height: 28.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Center(
                    child: Container(
                      width: (_brushSize / 50) * 16.w + 4.w,
                      height: (_brushSize / 50) * 16.w + 4.w,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: 12.h),

        // Action Buttons Row
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildActionButton(Icons.undo, () => _controller.undo()),
            SizedBox(width: 12.w),
            _buildActionButton(Icons.redo, () => _controller.redo()),
            SizedBox(width: 12.w),
            _buildActionButton(Icons.delete_outline, () => _controller.clear()),
            SizedBox(width: 12.w),
            _buildActionButton(Icons.save, _downloadImage),
          ],
        ),

        // زرار Next ثابت تحت ومبيتحركش
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
          child: _isSaving
              ? const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.secondaryColor,
                  ),
                )
              : CustomButton(text: widget.buttonText, onPressed: _extractAndProceed),
        ),
        SizedBox(height: 16.h),
      ],
    );
  }
}
