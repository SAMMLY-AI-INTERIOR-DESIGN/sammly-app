import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/routing/routes.dart';
import 'package:sammly/core/theme/text_styles.dart';
import 'package:sammly/generated/l10n.dart';

class NotEnoughTokensDialog extends StatelessWidget {
  const NotEnoughTokensDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.whiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Close Button
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(
                  Icons.close,
                  color: AppColors.primaryColor,
                  size: 24.r,
                ),
              ),
            ),
            
            SizedBox(height: 16.h),
            
            // Image
            SvgPicture.asset(
              'assets/images/starsnotenough.svg',
              height: 100.h,
              fit: BoxFit.contain,
            ),
            
            SizedBox(height: 24.h),
            
            // Title
            Text(
              S.of(context).tokensAreNotEnough,
              style: AppTextStyles.title20Bold.copyWith(
                color: AppColors.blackColor,
              ),
              textAlign: TextAlign.center,
            ),
            
            SizedBox(height: 8.h),
            
            // Subtitle
            Text(
              S.of(context).upgradeToContinue,
              style: AppTextStyles.body16Regular.copyWith(
                color: AppColors.greyColor,
              ),
              textAlign: TextAlign.center,
            ),
            
            SizedBox(height: 32.h),
            
            // Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      side: const BorderSide(color: AppColors.primaryColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                    ),
                    child: Text(
                      S.of(context).cancel,
                      style: AppTextStyles.body16Regular.copyWith(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromARGB(255, 27, 176, 127), // Green
                          AppColors.primaryColor, // Blue
                        ],
                        begin: AlignmentDirectional.centerEnd,
                        end: AlignmentDirectional.centerStart,
                      ),
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context); // Close dialog
                        // Navigate to subscription/upgrade screen
                        Navigator.pushNamed(context, AppRoutes.subscriptionView);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                      ),
                      child: Text(
                        S.of(context).upgrade,
                        style: AppTextStyles.body16Regular.copyWith(
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
