import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/constant/app_strings.dart';
import 'package:sammly/core/theme/text_styles.dart';

class GenerateLoadingView extends StatelessWidget {
  final String imagePath;
  final String title;

  const GenerateLoadingView({
    super.key,
    required this.imagePath,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              
              SvgPicture.asset(
                imagePath,
                height: 80.h, 
                fit: BoxFit.contain,
              ),
              
              SizedBox(height: 4.h),
              
              Text(
                title,
                textAlign: TextAlign.center,
                style: AppTextStyles.title18SemiBold.copyWith(color: AppColors.blackColor),
              ),
              
              const Spacer(),
              
              Text(
                AppStrings.loadingDisclaimer,
                textAlign: TextAlign.center,
                style: AppTextStyles.body14Regular.copyWith(
                  color: Colors.grey.shade500,
                  height: 1.5,
                ),
              ),
              
              SizedBox(height: 40.h), 
            ],
          ),
        ),
      ),
    );
  }
}