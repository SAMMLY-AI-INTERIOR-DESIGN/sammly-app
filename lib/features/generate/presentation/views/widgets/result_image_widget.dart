import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/constant/app_images.dart';
import 'package:sammly/core/constant/app_strings.dart';
import 'package:sammly/core/theme/text_styles.dart';

class ResultImageWidget extends StatelessWidget {
  final String imagePath;
  final VoidCallback? onSmartLensTap;
  const ResultImageWidget({super.key, required this.imagePath, this.onSmartLensTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 400.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.fill),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 16.h,
            left: 16.w,
            child: GestureDetector(
              onTap: onSmartLensTap,
              child: ClipRRect( // لازم عشان الـ Blur مايفرشحش بره
                borderRadius: BorderRadius.circular(20.r),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      // استخدمنا أسود شفاف عشان يدي تأثير الزجاج الغامق زي الديزاين
                      color: Colors.white.withValues(alpha: 0.2), 
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(
                        // بوردر أبيض شفاف بيدي لمعة خفيفة
                        color: Colors.white.withValues(alpha: 0.3), 
                        width: 1.5,
                      ),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(AppImages.smartLensIcon),
                        SizedBox(width: 8.w),
                        Text(
                          AppStrings.smartLens,
                          style: AppTextStyles.badge14SemiBold.copyWith(
                            color: Colors.white, // النص أبيض عشان يبان على الزجاج الغامق
                            fontSize: 16.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 16.h,
            left: 16.w,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: BackdropFilter(
                // 1. زودنا الـ Blur لـ 12 عشان نعزل تفاصيل الصورة اللي ورا أكتر
                filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    // 2. رفعنا شفافية الأبيض لـ 0.45 عشان يعمل خلفية قوية تسند الكلمة
                    color: Colors.white.withValues(alpha: 0.2),
                    border: Border.all(
                      // وضحنا البوردر سيكا برضه
                      color: Colors.white.withValues(alpha: 0.3),
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        AppImages.aiPoweredIcon,
                        width: 16.w,
                        height: 16.h,
                        colorFilter: const ColorFilter.mode(
                          AppColors.whiteColor,
                          BlendMode.srcIn,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        AppStrings.generatedBySammly,
                        style: AppTextStyles.body16Medium.copyWith(
                          color: AppColors.whiteColor,
                          fontSize: 14,
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
    );
  }
}
