import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/constant/app_images.dart';
import 'package:sammly/core/constant/app_strings.dart';
import 'package:sammly/core/functions.dart';
import 'package:sammly/core/theme/text_styles.dart';
import 'package:sammly/core/widgets/custombutton.dart';

class Step1Upload extends StatefulWidget {
  final XFile? initialImage;
  final Function(XFile) onImageSelected;
  final Function() onImageRemoved;
  final VoidCallback onNext;
  final String title;
  final String subtitle;
  final String? titleIcon; 
  final bool isButtonInsideCard; 
  final bool isImageOptional;

  const Step1Upload({
    super.key,
    this.initialImage,
    required this.onImageSelected,
    required this.onImageRemoved,
    required this.onNext,
    required this.title,
    required this.subtitle,
    this.titleIcon,
    this.isButtonInsideCard = false,
    this.isImageOptional = false,
  });

  @override
  State<Step1Upload> createState() => _Step1UploadState();
}

class _Step1UploadState extends State<Step1Upload> {
  XFile? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _selectedImage = widget.initialImage;
  }

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _selectedImage = image;
        });
        widget.onImageSelected(image);
      }
    } catch (e) {
      debugPrint("Error picking image: $e");
    }
  }

  void _removeImage() {
    setState(() {
      _selectedImage = null;
    });
    widget.onImageRemoved();
  }

  @override
  Widget build(BuildContext context) {
    
    Widget imageUploadArea = _selectedImage != null
        ? Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: AppColors.bg1Color, width: 2),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14.r),
                  child: Image.file(
                    File(_selectedImage!.path),
                    height: 250.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 10.h,
                right: 10.w,
                child: GestureDetector(
                  onTap: _removeImage,
                  child: Container(
                    width: 32.w,
                    height: 32.h,
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.5),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 18.sp,
                    ),
                  ),
                ),
              ),
            ],
          )
        : GestureDetector(
            onTap: _pickImage,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: DottedBorder(
                color: Colors.grey.shade400,
                strokeWidth: 1.5,
                dashPattern: const [6, 4],
                borderType: BorderType.RRect,
                radius: Radius.circular(12.r),
                child: Container(
                  height: 250.h,
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(AppImages.uploadImage, width: 24.w, height: 24.h),
                      SizedBox(height: 8.h),
                      Text(
                        widget.subtitle,
                        style: AppTextStyles.body14Regular.copyWith(
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );

   Widget nextButton = CustomButton(
      text: AppStrings.next,
      suffixIcon: AppImages.arrowRight,
      onPressed: (_selectedImage != null || widget.isImageOptional)
          ? widget.onNext
          : () {
              showCustomSnackBar(
                context: context,
                message: AppStrings.pleaseUploadImage,
                isError: true,
              );
            },
    );

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              if (widget.titleIcon != null) ...[
                SvgPicture.asset(widget.titleIcon!, width: 24.w, height: 24.h),
                SizedBox(width: 8.w),
              ],
              Text(
                widget.title,
                style: AppTextStyles.title20SemiBold.copyWith(
                  color: AppColors.blackColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          if (widget.isButtonInsideCard)
            Container(
              padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 20.w),
              decoration: BoxDecoration(
                gradient: AppColors.scafoldBg1Gradient,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Column(
                children: [
                  imageUploadArea,
                  SizedBox(height: 24.h),
                  nextButton,
                ],
              ),
            )
          else ...[
            Container(
              padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 20.w),
              decoration: BoxDecoration(
                gradient: AppColors.scafoldBg1Gradient,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: imageUploadArea,
            ),
            const Spacer(),
            nextButton,
          ],
          
          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}
