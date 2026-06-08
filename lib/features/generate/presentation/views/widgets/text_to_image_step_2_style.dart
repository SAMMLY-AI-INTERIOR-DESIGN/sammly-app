import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/constant/app_images.dart';
import 'package:sammly/core/constant/app_strings.dart';
import 'package:sammly/core/functions.dart';
import 'package:sammly/core/theme/text_styles.dart';
import 'package:sammly/core/widgets/custombutton.dart';

class TextToImageStep2Style extends StatelessWidget {
  final String? selectedStyle;
  final Function(String) onStyleSelected;
  final VoidCallback onNext;
  final String? buttonText;
  final String? buttonPrefixIcon;
  final String? buttonSuffixIcon;

  const TextToImageStep2Style({
    super.key,
    required this.selectedStyle,
    required this.onStyleSelected,
    required this.onNext,
    this.buttonText,
    this.buttonPrefixIcon,
    this.buttonSuffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> styles = [
      {'name': AppStrings.traditional, 'image': AppImages.roomLivingBohoTraditional},
      {'name': AppStrings.coastal, 'image': AppImages.styleCoastal},
      {'name': AppStrings.rustic, 'image': AppImages.styleRustic},
      {'name': AppStrings.midCenturyModern, 'image': AppImages.styleMidCentury},
      {'name': AppStrings.boho, 'image': AppImages.roomLivingBohoTraditional},
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: ListView.separated(
                padding: EdgeInsets.only(top: 16.h, bottom: 16.h),
                itemCount: styles.length,
                separatorBuilder: (context, index) => SizedBox(height: 16.h),
                itemBuilder: (context, index) {
                  final style = styles[index];
                  final isSelected = selectedStyle == style['name'];
              
                  return GestureDetector(
                    onTap: () => onStyleSelected(style['name']!),
                    child: Container(
                      padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          gradient: isSelected ? AppColors.primaryGradient3 : null,
                          color: isSelected ? null : Colors.transparent,
                          borderRadius: BorderRadius.circular(16.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                      child: Container(
                        height: 230.h,
                        decoration: BoxDecoration(
                          color: AppColors.roomItemBgColor,
                          borderRadius: BorderRadius.circular(16.r),
                          
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(14.r)),
                                child: Image.asset(
                                  style['image']!,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      color: Colors.grey.shade200,
                                      child: const Icon(Icons.image_not_supported, color: Colors.grey),
                                    );
                                  },
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 12.h),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: AppColors.bg1Color.withValues(alpha: 0.3),
                                borderRadius: BorderRadius.vertical(bottom: Radius.circular(14.r)),
                              ),
                              child: Text(
                                style['name']!,
                                style: AppTextStyles.title18SemiBold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          CustomButton(
            text: buttonText ?? AppStrings.next,
            prefixIcon: buttonPrefixIcon,
            suffixIcon: buttonPrefixIcon != null ? buttonSuffixIcon : (buttonSuffixIcon ?? AppImages.arrowRight),
            onPressed: selectedStyle != null
                ? onNext
                : () {
                    showCustomSnackBar(context: context, message: AppStrings.pleaseSelectAStyle, isError: true);
                  },
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}
