import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/theme/text_styles.dart';
import 'package:sammly/core/widgets/custombutton.dart';
import 'package:sammly/generated/l10n.dart';

class Step3Describe extends StatelessWidget {
  final TextEditingController promptController;
  final VoidCallback onGenerate;

  const Step3Describe({
    super.key,
    required this.promptController,
    required this.onGenerate,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(
                Icons.auto_awesome,
                color: Colors.grey.shade600,
                size: 24.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                S.of(context).describeYourChanges,
                style: AppTextStyles.title20SemiBold.copyWith(
                  color: AppColors.blackColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.bg1Color.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(16.r),
              ),
              padding: EdgeInsets.all(16.w),
              child: TextField(
                controller: promptController,
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
                style: AppTextStyles.body14Regular.copyWith(
                  color: AppColors.blackColor2,
                ),
                decoration: InputDecoration(
                  hintText: S.of(context).describeChangesHint,
                  hintStyle: AppTextStyles.body14Regular.copyWith(
                    color: Colors.grey.shade500,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(
                      color: Colors.grey.shade300,
                      width: 1,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(
                      color: Colors.grey.shade300,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: const BorderSide(
                      color: AppColors.secondaryColor,
                      width: 1.5,
                    ),
                  ),
                  filled: true,
                  fillColor: AppColors.whiteColor,
                  contentPadding: EdgeInsets.all(16.w),
                ),
              ),
            ),
          ),

          SizedBox(height: 16.h),
          CustomButton(text: S.of(context).generateDesignBtn, onPressed: onGenerate),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}
