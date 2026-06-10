import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_mask_painter/flutter_mask_painter.dart';
import 'package:flutter_mask_painter/mask_painter_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/theme/text_styles.dart';
import 'package:sammly/core/widgets/custombutton.dart';

class Step2Mask extends StatefulWidget {
  final XFile uploadedImage;
  final Function(XFile) onNext;

  const Step2Mask({
    super.key,
    required this.uploadedImage,
    required this.onNext,
  });

  @override
  State<Step2Mask> createState() => _Step2MaskState();
}

class _Step2MaskState extends State<Step2Mask> {
  final MaskPainterController _controller = MaskPainterController();
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _controller.setBrushSize(25.0); // Default brush size
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

  @override
  Widget build(BuildContext context) {
    // الكولوم الأساسي بياخد مساحة الشاشة
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Draw the Mask",
                style: AppTextStyles.title20SemiBold.copyWith(
                  color: AppColors.blackColor,
                ),
              ),
              // Toolbar
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.undo, color: AppColors.primaryColor),
                    onPressed: () => _controller.undo(),
                  ),
                  IconButton(
                    icon: const Icon(Icons.redo, color: AppColors.primaryColor),
                    onPressed: () => _controller.redo(),
                  ),
                ],
              ),
            ],
          ),
        ),

        // 💡 Expanded: عشان يزق زرار Next لآخر الشاشة تحت وياخد هو الباقي
        Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: AppColors.bg1Color, width: 2),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14.r),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: Center(
                        child: MaskPainterWidget(
                          backgroundImage: widget.uploadedImage,
                          controller: _controller,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
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
              : CustomButton(text: "Next", onPressed: _extractAndProceed),
        ),
        SizedBox(height: 16.h),
      ],
    );
  }
}
