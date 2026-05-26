import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/constant/app_images.dart';

class CustomHeartItem extends StatelessWidget {
  const CustomHeartItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(6.w),
      decoration: BoxDecoration(
        color: AppColors.bg2Color,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: SvgPicture.asset(AppImages.heartFilled, width: 12.w, height: 12.h),
    );
  }
}
