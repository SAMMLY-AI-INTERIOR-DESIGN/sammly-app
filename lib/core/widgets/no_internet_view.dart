import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/constant/app_images.dart';
import 'package:sammly/core/theme/text_styles.dart';

class NoInternetView extends StatelessWidget {
  const NoInternetView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.primaryColor,
            size: 24.sp,
          ),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AppImages.noNetwork,
                width: 250.w,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 24.h),
              Text(
                'No Internet Connection',
                style: AppTextStyles.title20Bold,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12.h),
              Text(
                'Please check your internet connection and try again.',
                style: AppTextStyles.body16Regular.copyWith(
                  color: AppColors.greyColor,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
