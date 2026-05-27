import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/constant/app_strings.dart';
import 'package:sammly/core/routing/routes.dart';
import 'package:sammly/core/theme/text_styles.dart';
import 'package:sammly/core/widgets/custom_appbar.dart';
import 'package:sammly/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:sammly/features/profile/presentation/views/widgets/security_menu_group.dart';

class SecurityView extends StatelessWidget {
  const SecurityView({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = context.read<ProfileCubit>().currentProfile;
    final email = profile?.email ?? 'No email found';

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: const CustomAppbar(title: AppStrings.security),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
        // 💡 استخدم الودجت الجديدة هنا
        child: SecurityMenuGroup(
          children: [
            // Email row
            InkWell(
              borderRadius: BorderRadius.circular(12.r),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
                child: Row(
                  children: [
                    Icon(
                      Icons.email_outlined,
                      size: 22.w,
                      color: AppColors.whiteColor,
                    ).withAppGradient(),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.email,
                            style: AppTextStyles.body16Medium,
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            email,
                            style: AppTextStyles.body14Regular.copyWith(
                              color: AppColors.greyColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Change Password row
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.changePasswordView);
              },
              borderRadius: BorderRadius.circular(12.r),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
                child: Row(
                  children: [
                    Icon(
                      Icons.lock_outline,
                      size: 22.w,
                      color: AppColors.whiteColor,
                    ).withAppGradient(),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.changePassword,
                            style: AppTextStyles.body16Medium,
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            'Update your password',
                            style: AppTextStyles.body14Regular.copyWith(
                              color: AppColors.greyColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 20.sp,
                      color: AppColors.blackColor2,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
