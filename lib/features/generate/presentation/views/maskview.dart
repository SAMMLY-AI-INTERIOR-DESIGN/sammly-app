import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_mask_painter/mask_painter_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_mask_painter/flutter_mask_painter.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart'; // لاستخدام XFile
import 'package:image/image.dart' as img;
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/generated/l10n.dart';
import 'package:sammly/core/widgets/custombutton.dart';

class MaskInpaintingView extends StatefulWidget {
  final String imageUrl;

  const MaskInpaintingView({super.key, required this.imageUrl});

  @override
  State<MaskInpaintingView> createState() => _MaskInpaintingViewState();
}

class _MaskInpaintingViewState extends State<MaskInpaintingView> {
  final MaskPainterController _controller = MaskPainterController();
  XFile? _backgroundImage;
  bool _isLoadingImage = true;
  bool _isSending = false;

  @override
  void initState() {
    super.initState();
    _prepareImage();
  }

  // 💡 دالة سحرية لتحويل رابط الصورة إلى XFile عشان الباكدج تقبلها
  Future<void> _prepareImage() async {
    try {
      final response = await http.get(Uri.parse(widget.imageUrl));
      final documentDirectory = await getTemporaryDirectory();

      // بنعمل ملف مؤقت في الجهاز
      final file = File('${documentDirectory.path}/temp_mask_bg.png');
      await file.writeAsBytes(response.bodyBytes);

      setState(() {
        _backgroundImage = XFile(file.path);
        _isLoadingImage = false;
      });

      // تحديد حجم الفرشة الافتراضي
      _controller.setBrushSize(30.0);
    } catch (e) {
      debugPrint("Error loading image: $e");
      setState(() => _isLoadingImage = false);
    }
  }

  // دالة إرسال الماسك للباك إند
  Future<void> _submitMask() async {
    setState(() => _isSending = true);

    try {
      // بنخلي الكنترولر يطلع الصورة الأبيض والأسود النهائية
      final XFile? maskFile = await _controller.saveMask();

      if (maskFile != null) {
        // Threshold the mask to ensure pure white (value 255) for the AI backend
        final bytes = await maskFile.readAsBytes();
        final image = img.decodeImage(bytes);
        if (image != null) {
          for (final p in image) {
            if (p.r > 5 || p.g > 5 || p.b > 5) {
              p.setRgba(255, 255, 255, 255);
            } else {
              p.setRgba(0, 0, 0, 255);
            }
          }
          final processedBytes = img.encodePng(image);
          final file = File(maskFile.path);
          await file.writeAsBytes(processedBytes);
        }

        // هنا بتجهز الريكويست بتاعك للـ API بـ Dio
        // MultipartFile.fromFileSync(maskFile.path)

        debugPrint("Mask saved at: ${maskFile.path}");
        if (!mounted) return;
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text(S.of(context).waitText),
              backgroundColor: AppColors.secondaryColor,
            ),
          );

        // محاكاة إرسال للباك إند
        await Future.delayed(const Duration(seconds: 2));
      }
    } catch (e) {
      debugPrint("Error saving mask: $e");
    } finally {
      setState(() => _isSending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.blackColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          S.of(context).drawMaskTitle,
          style: TextStyle(
            color: AppColors.blackColor,
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        // أدوات التحكم في الباكدج
        actions: [
          IconButton(
            icon: const Icon(Icons.undo, color: AppColors.primaryColor),
            onPressed: () => _controller.undo(),
          ),
          IconButton(
            icon: const Icon(Icons.redo, color: AppColors.primaryColor),
            onPressed: () => _controller.redo(),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.red),
            onPressed: () => _controller.clear(),
          ),
        ],
      ),
      body: _isLoadingImage
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // تعليمات لليوزر
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 8.h,
                  ),
                  child: Text(
                    S.of(context).drawMaskInstruction,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.greyColor,
                      fontSize: 14.sp,
                    ),
                  ),
                ),

                // مساحة الرسم (الباكدج)
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(color: AppColors.bg1Color, width: 2),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14.r),
                      child: MaskPainterWidget(
                        backgroundImage: _backgroundImage!,
                        controller: _controller,
                        // تقدر تستخدم دي لو عاوز تستقبل الملف أوتوماتيك أول ما يترسم
                        // onMaskSaved: (maskFile) {},
                      ),
                    ),
                  ),
                ),

                // زرار التأكيد
                Padding(
                  padding: EdgeInsets.all(20.w),
                  child: _isSending
                      ? const Center(child: CircularProgressIndicator())
                      : CustomButton(
                          text: S.of(context).generateMaskBtn,
                          onPressed: _submitMask,
                        ),
                ),
              ],
            ),
    );
  }
}
