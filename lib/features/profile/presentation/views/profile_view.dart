import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/constant/app_images.dart';
import 'package:sammly/core/constant/app_strings.dart';
import 'package:sammly/core/theme/text_styles.dart';
import 'package:sammly/features/profile/presentation/views/widgets/invite_friends_widget.dart';
import 'package:sammly/features/profile/presentation/views/widgets/logout_bottom_sheet.dart';
import 'package:sammly/features/profile/presentation/views/widgets/profile_menu_group.dart';
import 'package:sammly/features/profile/presentation/views/widgets/profile_menu_item.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 350.h,
            child: ShaderMask(
              shaderCallback: (rect) {
                return AppColors.profileGradient.createShader(rect);
              },
              blendMode: BlendMode.dstIn,
              child: Image.asset(
                AppImages.profileBgPlaceholder,
                fit: BoxFit.cover,
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios_new,
                          size: 25.sp,
                          color: AppColors.whiteColor,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Text(
                        AppStrings.profile,
                        style: AppTextStyles.title20Bold.copyWith(
                          color: AppColors.whiteColor,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          gradient: AppColors.primaryGradient3,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.notifications,
                          color: Colors.white,
                          size: 20.sp,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 24.h),

                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(
                        color: AppColors.whiteColor.withValues(alpha: 0.5),
                        width: 1.5,
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16.r),
                              child: SvgPicture.asset(
                                AppImages.maleProfilePlaceholder,
                                width: 65.w,
                                height: 65.h,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Abdallah",
                                    style: AppTextStyles.title18SemiBold,
                                  ),
                                  Text(
                                    "@abdallah22",
                                    style: AppTextStyles.body14Regular.copyWith(
                                      color: AppColors.greyColor,
                                    ),
                                  ),
                                  Text(
                                    "Joint December 2024",
                                    style: AppTextStyles.body14Regular.copyWith(
                                      color: AppColors.greyColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SvgPicture.asset(AppImages.edit),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            padding: const EdgeInsets.all(1.5),
                            decoration: BoxDecoration(
                              gradient: AppColors.primaryGradient3,
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 6.h,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.r),
                                color: AppColors.whiteColor.withValues(
                                  alpha: 0.8,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset(
                                    AppImages.upgrade,
                                    width: 16.w,
                                  ),
                                  SizedBox(width: 6.w),
                                  ShaderMask(
                                    shaderCallback: (bounds) {
                                      return AppColors.primaryGradient3
                                          .createShader(bounds);
                                    },
                                    child: Text(
                                      AppStrings.upgradePro,
                                      style: AppTextStyles.body14Regular
                                          .copyWith(
                                            color: AppColors.whiteColor,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 24.h),

                  // المجموعة الأولى
                  ProfileMenuGroup(
                    children: [
                      ProfileMenuItem(
                        title: AppStrings.viewMyPosts,
                        svgIcon: AppImages.profileIcon,
                        onTap: () {},
                      ),
                      ProfileMenuItem(
                        title: AppStrings.favorites,
                        svgIcon: AppImages.favorites,
                        onTap: () {},
                      ),
                      ProfileMenuItem(
                        title: AppStrings.following,
                        svgIcon: AppImages.following,
                        onTap: () {},
                      ),
                    ],
                  ),

                  // المجموعة التانية
                  ProfileMenuGroup(
                    children: [
                      ProfileMenuItem(
                        title: AppStrings.freeGenerations,
                        svgIcon: AppImages.aiPoweredIcon,
                        trailing: Text(
                          "5",
                          style: AppTextStyles.badge14SemiBold,
                        ), // رقم بدل السهم
                        onTap: () {},
                      ),
                      ProfileMenuItem(
                        title: AppStrings.manageSubscription,
                        svgIcon: AppImages.manageSubscriptions,
                        onTap: () {},
                      ),
                    ],
                  ),

                  // المجموعة التالتة
                  ProfileMenuGroup(
                    children: [
                      ProfileMenuItem(
                        title: AppStrings.support,
                        svgIcon: AppImages.support,
                        onTap: () {},
                      ),
                      ProfileMenuItem(
                        title: AppStrings.notification,
                        svgIcon: AppImages.notifications,
                        trailing: Switch(
                          value: false,
                          activeThumbColor: AppColors.whiteColor,
                          activeTrackColor: AppColors.secondaryColor,
                          inactiveThumbColor: AppColors.whiteColor,
                          inactiveTrackColor: AppColors.greyColor.withValues(
                            alpha: 0.2,
                          ),
                          trackOutlineColor: WidgetStateProperty.all(
                            Colors.transparent,
                          ),

                          thumbIcon: WidgetStateProperty.all(const Icon(null)),

                          onChanged: (val) {},
                        ),
                      ),
                    ],
                  ),

                  ProfileMenuGroup(
                    children: [
                      ProfileMenuItem(
                        title: AppStrings.termsConditions,
                        svgIcon: AppImages.terms,
                        onTap: () {},
                      ),
                      ProfileMenuItem(
                        title: AppStrings.privacyPolicy,
                        svgIcon: AppImages.privacy,
                        onTap: () {},
                      ),
                    ],
                  ),

                  ProfileMenuGroup(
                    children: [
                      ProfileMenuItem(
                        title: AppStrings.share,
                        svgIcon: AppImages.share,
                        onTap: () {
                          showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (BuildContext context) {
                              return InviteFriendsDialog();
                            },
                          );
                        },
                      ),
                    ],
                  ),

                  ProfileMenuGroup(
                    children: [
                      ProfileMenuItem(
                        title: AppStrings.logOut,
                        svgIcon: AppImages.logOut,
                        textColor: Colors.red.shade400,
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 20.sp,
                          color: AppColors.blackColor2,
                        ),
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            backgroundColor: Colors
                                .transparent, 
                            isScrollControlled: true,
                            builder: (context) {
                              return const LogoutBottomSheet();
                            },
                          );
                        },
                      ),
                    ],
                  ),

                  SizedBox(height: 30.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
