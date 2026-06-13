import 'dart:io';
import 'package:sammly/core/widgets/avatar_widget.dart';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/constant/app_images.dart';
import 'package:sammly/core/constant/app_strings.dart';
import 'package:sammly/core/theme/text_styles.dart';

class EditImageSection extends StatefulWidget {
  final ValueChanged<File?> onImagePicked;
  final String? currentAvatarUrl;

  const EditImageSection({
    super.key,
    required this.onImagePicked,
    this.currentAvatarUrl,
  });

  @override
  State<EditImageSection> createState() => _EditImageSectionState();
}

class _EditImageSectionState extends State<EditImageSection> {

  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxHeight: 800,
      maxWidth: 800,
    );
    
    if (pickedFile != null) {
      final CroppedFile? croppedFile = await _cropImage(pickedFile.path);
      if (croppedFile != null) {
        setState(() {
          _selectedImage = File(croppedFile.path);
        });
        widget.onImagePicked(_selectedImage);
      }
    }
  }

  Future<CroppedFile?> _cropImage(String path) async {
    return await ImageCropper().cropImage(
      sourcePath: path,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: AppColors.primaryColor,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: true,
          activeControlsWidgetColor: AppColors.secondaryColor,
          cropStyle: CropStyle.circle,
          aspectRatioPresets: [CropAspectRatioPreset.square],
        ),
        IOSUiSettings(
          title: 'Crop Image',
          aspectRatioLockEnabled: true,
          resetAspectRatioEnabled: false,
          cropStyle: CropStyle.circle,
          aspectRatioPresets: [CropAspectRatioPreset.square],
        ),
      ],
    );
  }

  Widget _buildImageContent() {
    // 1. User picked a new image
    if (_selectedImage != null) {
      return ClipOval(
        child: Image.file(_selectedImage!, fit: BoxFit.cover, width: 140.w, height: 140.h),
      );
    }

    // 2. Current avatar from API
    if (widget.currentAvatarUrl != null && widget.currentAvatarUrl!.isNotEmpty) {
      return AvatarWidget(
        avatarPath: widget.currentAvatarUrl,
        width: 140.w,
        height: 140.h,
        borderRadius: BorderRadius.circular(70.r),
      );
    }

    // 3. No image — show upload placeholder
    return _buildUploadPlaceholder();
  }

  Widget _buildUploadPlaceholder() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(AppImages.uploadImage, width: 24.w, height: 24.h),
          SizedBox(height: 4.h),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              AppStrings.uploadImage,
              style: AppTextStyles.body16Medium.copyWith(
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
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
                child: SizedBox(
                  width: 150.w,
                  height: 150.h,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      DottedBorder(
                        color: AppColors.greyColor.withValues(alpha: 0.5),
                        strokeWidth: 1.5,
                        dashPattern: const [8, 6],
                        borderType: BorderType.Circle,
                        child: Container(
                          width: 140.w,
                          height: 140.h,
                          decoration: const BoxDecoration(shape: BoxShape.circle),
                          child: _buildImageContent(),
                        ),
                      ),
                      if (_selectedImage != null || (widget.currentAvatarUrl != null && widget.currentAvatarUrl!.isNotEmpty))
                        Positioned(
                          bottom: 4.h,
                          right: 8.w,
                          child: Container(
                            padding: EdgeInsets.all(6.r),
                            decoration: BoxDecoration(
                              gradient: AppColors.primaryGradient3,
                              shape: BoxShape.circle,
                              border: Border.all(color: AppColors.whiteColor, width: 2.5),
                            ),
                            child: Icon(Icons.edit, color: AppColors.whiteColor, size: 18.sp),
                          ),
                        ),
                    ],
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

