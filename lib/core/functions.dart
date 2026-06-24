import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/theme/text_styles.dart';

void showCustomSnackBar({
  required BuildContext context,
  required String message,
  bool isError = false,
}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: AppTextStyles.body14Regular.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
      backgroundColor: (message == 'Under maintenance' || message == 'تحت الصيانة')
          ? AppColors.primaryColor
          : (isError ? Colors.red.shade400 : AppColors.secondaryColor),

      behavior: SnackBarBehavior.floating,

      margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),

      duration: const Duration(seconds: 3),

      elevation: 0,
    ),
  );
}
