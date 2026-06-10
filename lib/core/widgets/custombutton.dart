import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart'; 
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/theme/text_styles.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final String? prefixIcon; 
  final String? suffixIcon;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.prefixIcon,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 55.h,
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient2,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withValues(alpha: 0.22),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.r),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (prefixIcon != null) ...[
              SvgPicture.asset(
                prefixIcon!,
                
                colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn), 
              ),
              SizedBox(width: 8.w),
            ],

            Text(
              text,
              style: AppTextStyles.button20Medium,
            ),

            if (suffixIcon != null) ...[
              SizedBox(width: 12.w),
              SvgPicture.asset(suffixIcon!, width: 10.w, height: 12.h,)
            ],
          ],
        ),
      ),
    );
  }
}