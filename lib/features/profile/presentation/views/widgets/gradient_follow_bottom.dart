import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/constant/app_strings.dart';
import 'package:sammly/core/theme/text_styles.dart';

class GradientFollowButton extends StatelessWidget {
  final VoidCallback onPressed;

  const GradientFollowButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38.h, // ارتفاع مناسب لزرار الـ Follow
      decoration: BoxDecoration(
        // الجرادينت الرأسي من الأزرق للأخضر
        gradient: AppColors.primaryGradient3,
        borderRadius: BorderRadius.circular(8.r), // حواف دائرية خفيفة
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent, // عشان الجرادينت يبان
          shadowColor: Colors.transparent,
          elevation: 0,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min, // عشان الزرار ياخد مساحة المحتوى بس
          children: [
            // 1. الدايرة البيضا اللي جواها علامة (+)
            Container(
              padding: EdgeInsets.all(2.w),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.add,
                color: AppColors.secondaryColor, // علامة الزائد بلون أخضر/Teal
                size: 16.sp,
              ),
            ),
            
            SizedBox(width: 8.w),
            
            // 2. كلمة Follow
            Text(
              AppStrings.follow,
              style: AppTextStyles.body16Medium.copyWith(
                color: Colors.white,
                fontSize: 15.sp,
                letterSpacing: 0.5, // مسافة خفيفة بين الحروف
              ),
            ),
          ],
        ),
      ),
    );
  }
}