import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/theme/text_styles.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String? initialValue;
  final Widget? suffixIcon;
  final Widget? prefix;
  final TextEditingController? controller;
  final void Function(String)? onChanged;

  const CustomTextField({
    super.key,
    required this.label,
    this.initialValue,
    this.suffixIcon,
    this.prefix,
    this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: const EdgeInsets.all(1.5), 
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient3,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: AppColors.textFieldBodyColor, 
          borderRadius: BorderRadius.circular(7.r),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (prefix != null) ...[
              prefix!,
              SizedBox(width: 8.w),
            ],
            
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min, 
                children: [
                  Text(
                    label,
                    style: AppTextStyles.body14Regular,
                  ),
                  
                  TextFormField(
                    controller: controller,
                    initialValue: controller == null ? initialValue : null,
                    onChanged: onChanged,
                    style: AppTextStyles.body14Regular,
                    decoration: const InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.zero, 
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                ],
              ),
            ),
            
            if (suffixIcon != null) ...[
              SizedBox(width: 8.w),
              suffixIcon!,
            ],
          ],
        ),
      ),
    );
  }
}