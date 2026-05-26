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

class EditImageSection extends StatefulWidget {

  const EditImageSection({super.key});

  @override
  State<EditImageSection> createState() => _EditImageSectionState();
}

class _EditImageSectionState extends State<EditImageSection> {

  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(1),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient3,
        borderRadius: BorderRadius.circular(12.r)
      ),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppStrings.changeImage, style: AppTextStyles.body14Regular.copyWith(color: AppColors.blackColor2)),
            SizedBox(height: 16.h),
            Center(
              child: GestureDetector(
                onTap: _pickImage,
                child: DottedBorder(
                  color: AppColors.greyColor.withValues(alpha: 0.5),
                  strokeWidth: 1.5,
                  dashPattern: const [8, 6],
                  borderType: BorderType.Circle,
                  child: Container(
                    width: 140.w,
                    height: 140.h,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: _selectedImage != null
                        ? ClipOval(
                            child: Image.file(_selectedImage!, fit: BoxFit.cover),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(AppImages.uploadImage, width: 40.w, height: 40.h),
                              SizedBox(height: 4.h),
                              Text(
                                AppStrings.uploadImage,
                                style: AppTextStyles.body16Medium.copyWith(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
