import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/theme/text_styles.dart';

class CustomActionButton extends StatelessWidget {
  final String title;
  final String? iconPath;
  final IconData? iconData;
  final Color? iconColor;
  final VoidCallback onTap;
  final double iconSize;
  final double? width;
  final double? height;

  const CustomActionButton({
    super.key,
    required this.title,
    this.iconPath,
    this.iconData,
    this.iconColor,
    required this.onTap,
    this.iconSize = 26.0,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final double buttonWidth = width ?? 117.w;
    final double buttonHeight = height ?? 95.h;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: buttonWidth,
        height: buttonHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13.r),
          gradient: const LinearGradient(
            colors: [AppColors.primaryColor, AppColors.secondaryColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(1.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            gradient: const LinearGradient(
              colors: [AppColors.bg1Color, AppColors.bg2Color],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (iconData != null)
                Icon(
                  iconData,
                  size: iconSize.sp,
                  color: iconColor ?? AppColors.primaryColor,
                )
              else if (iconPath != null)
                SvgPicture.asset(
                  iconPath!,
                  width: iconSize.sp,
                  height: iconSize.sp,
                ).withAppGradient(),
              SizedBox(height: 8.h),
              Text(
                title,
                style: TextStyle(
                  color: const Color(0xFF46505D),
                  fontSize: 18.65.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: AppTextStyles.primaryFont,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
