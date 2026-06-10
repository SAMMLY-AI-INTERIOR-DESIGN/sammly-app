
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/constant/app_images.dart';
import 'package:sammly/core/constant/app_strings.dart';
import 'package:sammly/core/routing/routes.dart';
import 'package:sammly/core/theme/text_styles.dart';
import 'package:sammly/core/widgets/avatar_widget.dart';
import 'package:sammly/features/profile/presentation/views/widgets/invite_friends_widget.dart';
import 'package:sammly/features/profile/presentation/views/widgets/logout_bottom_sheet.dart';
import 'package:sammly/features/profile/presentation/views/widgets/profile_menu_group.dart';
import 'package:sammly/features/profile/presentation/views/widgets/profile_menu_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sammly/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:sammly/features/profile/presentation/cubit/profile_state.dart';
import 'package:sammly/features/layout/presentation/cubit/layout_cubit/layout_cubit.dart';
import 'package:intl/intl.dart';

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
            child: Image.asset(
              AppImages.profileBgPlaceholder,
              fit: BoxFit.cover,
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
                          color: AppColors.blackColor2,
                        ),
                        onPressed: () {
                          context.read<LayoutCubit>().changeIndex(0);
                        },
                      ),
                      Text(
                        AppStrings.profile,
                        style: AppTextStyles.title20Bold.copyWith(
                          color: AppColors.blackColor2,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.notificationsView,
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(8.w),
                          decoration: const BoxDecoration(
                            gradient: AppColors.primaryGradient3,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.notifications,
                            color: Colors.white,
                            size: 20.sp,
                          ),
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
                    child: BlocBuilder<ProfileCubit, ProfileState>(
                      builder: (context, state) {
                        final profile = context
                            .read<ProfileCubit>()
                            .currentProfile;
                        String joinDate = "Loading...";
                        if (profile?.createdAt != null) {
                          try {
                            final date = DateTime.parse(profile!.createdAt!);
                            joinDate =
                                "Joined ${DateFormat('MMMM yyyy').format(date)}";
                          } catch (e) {
                            joinDate = "Joined Recently";
                          }
                        }
    
                        return Column(
                          children: [
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  AppRoutes.myProfileView,
                                );
                              },
                              child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AvatarWidget(
                                  avatarPath: profile?.avatar,
                                  width: 65.w,
                                  height: 65.h,
                                  borderRadius: BorderRadius.circular(16.r),
                                ),
                                SizedBox(width: 12.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        profile?.name ?? (state is ProfileLoading ? "Loading..." : "User"),
                                        style: AppTextStyles.title18SemiBold,
                                      ),
                                      Text(
                                        profile?.username != null
                                            ? "@${profile!.username}"
                                            : "@user",
                                        style: AppTextStyles.body14Regular
                                            .copyWith(
                                              color: AppColors.greyColor,
                                            ),
                                      ),
                                      Text(
                                        joinDate,
                                        style: AppTextStyles.body14Regular
                                            .copyWith(
                                              color: AppColors.greyColor,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      AppRoutes.editProfileView,
                                    );
                                  },
                                  child: SvgPicture.asset(AppImages.edit),
                                ),
                              ],
                            ),
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
                                      alpha: 0.9,
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
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 24.h),
                  ProfileMenuGroup(
                    children: [
                      ProfileMenuItem(
                        title: AppStrings.viewMyPosts,
                        svgIcon: AppImages.profileIcon,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.myProfileView,
                          );
                        },
                      ),
                      ProfileMenuItem(
                        title: AppStrings.favorites,
                        svgIcon: AppImages.favorites,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.favoriteView,
                          );
                        },
                      ),
                      ProfileMenuItem(
                        title: AppStrings.following,
                        svgIcon: AppImages.following,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.followingView,
                          );
                        },
                      ),
                    ],
                  ),
                  ProfileMenuGroup(
                    children: [
                      ProfileMenuItem(
                        title: AppStrings.freeGenerations,
                        svgIcon: AppImages.aiPoweredIcon,
                        trailing: Padding(
                          padding: EdgeInsets.only(right: 8.w),
                          child: Text(
                            "5",
                            style: AppTextStyles.badge14SemiBold,
                          ),
                        ),
                        onTap: () {},
                      ),
                      ProfileMenuItem(
                        title: AppStrings.manageSubscription,
                        svgIcon: AppImages.manageSubscriptions,
                        onTap: () {},
                      ),
                    ],
                  ),
                  ProfileMenuGroup(
                    children: [
                      ProfileMenuItem(
                        title: AppStrings.support,
                        svgIcon: AppImages.support,
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.supportView);
                        },
                      ),
                      ProfileMenuItem(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.notificationsView,
                          );
                        },
                        title: AppStrings.notification,
                        svgIcon: AppImages.notifications,
                      ),
                    ],
                  ),
                  ProfileMenuGroup(
                    children: [
                      ProfileMenuItem(
                        title: AppStrings.termsConditions,
                        svgIcon: AppImages.terms,
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.termsView);
                        },
                      ),
                      ProfileMenuItem(
                        title: AppStrings.privacyPolicy,
                        svgIcon: AppImages.privacy,
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.privacyView);
                        },
                      ),
                      ProfileMenuItem(
                        title: AppStrings.security,
                        svgIcon: AppImages.security,
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.securityView);
                        },
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
                            backgroundColor: Colors.transparent,
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
