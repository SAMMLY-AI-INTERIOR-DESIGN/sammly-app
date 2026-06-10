import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/constant/app_images.dart';
import 'package:sammly/core/constant/app_strings.dart';
import 'package:sammly/core/theme/text_styles.dart';
import 'package:sammly/core/widgets/custombutton.dart';

class TextToImageStep3Describe extends StatefulWidget {
  final TextEditingController promptController;
  final XFile? referenceImage;
  final Function(XFile) onImageSelected;
  final VoidCallback onImageRemoved;
  final VoidCallback onGenerate;

  const TextToImageStep3Describe({
    super.key,
    required this.promptController,
    required this.referenceImage,
    required this.onImageSelected,
    required this.onImageRemoved,
    required this.onGenerate,
  });

  @override
  State<TextToImageStep3Describe> createState() =>
      _TextToImageStep3DescribeState();
}

class _TextToImageStep3DescribeState extends State<TextToImageStep3Describe> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        widget.onImageSelected(image);
      }
    } catch (e) {
      debugPrint("Error picking image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20.w), 
              decoration: BoxDecoration(
                gradient: AppColors.scafoldBg1Gradient, 
                borderRadius: BorderRadius.circular(
                  20.r,
                ), 
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        AppImages.aiPoweredIcon,
                        width: 24.w,
                        height: 24.h,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        AppStrings.visualizeYourSpace,
                        style: AppTextStyles.title20SemiBold.copyWith(
                          color: AppColors.blackColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),

                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors
                            .whiteColor, 
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: TextField(
                        controller: widget.promptController,
                        maxLines: null,
                        expands: true,
                        keyboardType: TextInputType.text,
                        keyboardAppearance: Brightness.dark,
                        textAlignVertical: TextAlignVertical.top,
                        style: AppTextStyles.body14Regular.copyWith(
                          color: AppColors.blackColor2,
                        ),
                        decoration: InputDecoration(
                          hintText: AppStrings.describeDreamRoomHint,
                          hintStyle: AppTextStyles.body16Medium.copyWith(
                            color: Colors.grey.shade400,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(16.w),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 16.h),

                  Expanded(
                    child: widget.referenceImage != null
                        ? Stack(
                            children: [
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.r),
                                  border: Border.all(
                                    color: AppColors.bg1Color,
                                    width: 2,
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(14.r),
                                  child: Image.file(
                                    File(widget.referenceImage!.path),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 10.h,
                                right: 10.w,
                                child: GestureDetector(
                                  onTap: widget.onImageRemoved,
                                  child: Container(
                                    width: 32.w,
                                    height: 32.h,
                                    decoration: BoxDecoration(
                                      color: Colors.black.withValues(
                                        alpha: 0.5,
                                      ),
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
                                color:
                                    AppColors.whiteColor,
                                borderRadius: BorderRadius.circular(16.r),
                              ),
                              child: DottedBorder(
                                color: Colors.grey.shade400,
                                strokeWidth: 1.5,
                                dashPattern: const [6, 4],
                                borderType: BorderType.RRect,
                                radius: Radius.circular(16.r),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        AppImages.uploadImage,
                                        width: 24.w,
                                        height: 24.h,
                                      ),
                                      SizedBox(height: 8.h),
                                      Text(
                                        AppStrings.addReferenceImage,
                                        style: AppTextStyles.body16Medium
                                            .copyWith(
                                              color: Colors.grey.shade500,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 40.h),
          CustomButton(
            text: AppStrings.generateDesign,
            onPressed: widget.onGenerate,
            prefixIcon: AppImages.startGenerateIcon,
          ),
          SizedBox(height: 24.h), 
        ],
      ),
    );
  }
}
