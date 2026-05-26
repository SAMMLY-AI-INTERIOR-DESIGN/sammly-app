import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/constant/app_strings.dart';
import 'package:sammly/core/theme/text_styles.dart';

class ShareLinkTextField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onCopyTap;

  const ShareLinkTextField({
    super.key,
    required this.controller,
    required this.onCopyTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(1.5),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient3,
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22.5.r),
        ),
        child: TextFormField(
          controller: controller,
          keyboardType: TextInputType.url,
          minLines: 1,
          maxLines: 2,
          style: AppTextStyles.body14Regular.copyWith(
            color: Colors.grey.shade700,
            height: 1.4,
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(
              left: 16.w,
              right: 8.w,
              top: 12.h,
              bottom: 12.h,
            ),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,

            suffixIcon: Padding(
              padding: EdgeInsets.only(right: 4.w),
              child: TextButton(
                onPressed: onCopyTap,
                child: Text(
                  AppStrings.copyLink,
                  style: AppTextStyles.body16Medium.copyWith(
                    color: AppColors.primaryColor,
                    fontSize: 15.sp,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
