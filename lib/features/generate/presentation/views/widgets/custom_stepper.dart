import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/theme/text_styles.dart';

class CustomStepper extends StatelessWidget {
  final int currentStep;
  final List<String> stepTitles;

  const CustomStepper({
    super.key, 
    required this.currentStep,
    required this.stepTitles,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          stepTitles.length * 2 - 1,
          (index) {
            if (index.isEven) {
              return _buildStep(index ~/ 2, stepTitles[index ~/ 2]);
            } else {
              return _buildLine(index ~/ 2);
            }
          },
        ),
      ),
    );
  }

  Widget _buildStep(int stepIndex, String title) {
    bool isActive = currentStep >= stepIndex;

    return Column(
      children: [
        Container(
          width: 40.w,
          height: 40.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: AppColors.iconGradient, // Always gradient background
          ),
          padding: isActive ? null : EdgeInsets.all(1.5), // The "border width"
          alignment: Alignment.center,
          child: isActive
              ? Text(
                  "${stepIndex + 1}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                )
              : Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.bg2Color, // The inner color for inactive
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "${stepIndex + 1}",
                    style: TextStyle(
                      color: AppColors.blackColor2,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
        ),
        SizedBox(height: 8.h),
        Text(
          title,
          style: AppTextStyles.body14Regular.copyWith(
            color: isActive ? AppColors.blackColor2 : Colors.grey,
            fontWeight: isActive ? FontWeight.w500 : FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildLine(int stepIndex) {
    bool isActive = currentStep > stepIndex;

    return Expanded(
      child: Container(
        height: 1.5,
        margin: EdgeInsets.only(
          bottom: 24.h,
        ), // offset to align with circle center
        decoration: BoxDecoration(
          color: isActive ? null : AppColors.primaryColor.withValues(alpha: 0.3),
          gradient: isActive ? AppColors.iconGradient : null,
        ),
      ),
    );
  }
}
