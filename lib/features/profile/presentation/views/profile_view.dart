import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/constant/app_images.dart';
import 'package:sammly/core/routing/routes.dart';
import 'package:sammly/core/theme/text_styles.dart';
import 'package:sammly/core/widgets/avatar_widget.dart';
import 'package:sammly/core/localization/locale_cubit.dart';
import 'package:sammly/features/profile/presentation/views/widgets/invite_friends_widget.dart';
import 'package:sammly/features/profile/presentation/views/widgets/logout_bottom_sheet.dart';
import 'package:sammly/features/profile/presentation/views/widgets/profile_menu_group.dart';
import 'package:sammly/features/profile/presentation/views/widgets/profile_menu_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sammly/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:sammly/features/profile/presentation/cubit/profile_state.dart';
import 'package:sammly/features/layout/presentation/cubit/layout_cubit/layout_cubit.dart';
import 'package:sammly/generated/l10n.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  void initState() {
    super.initState();
    // Fetch settings data for profile header (avatar, name, username, joinedAt)
    context.read<ProfileCubit>().fetchSettingInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Stack(
        children: [
          PositionedDirectional(
            top: 0,
            start: 0,
            end: 0,
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
                        S.of(context).profile,
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
                        final cubit = context.read<ProfileCubit>();
                        final settingInfo = cubit.currentSettingInfo;
                        final profile = cubit.currentProfile;
                        final gender = profile?.gender;

                        // Use settingInfo first, fall back to profile data
                        final displayAvatar =
                            settingInfo?.avatar ?? profile?.avatar;
                        final displayName = settingInfo?.name ?? profile?.name;

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
                                    avatarPath: displayAvatar,
                                    gender: gender,
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
                                          displayName ??
                                              (state is SettingInfoLoading ||
                                                      state is ProfileLoading
                                                  ? "..."
                                                  : "User"),
                                          style: AppTextStyles.title18SemiBold,
                                        ),
                                        Text(
                                          settingInfo?.username != null
                                              ? "@${settingInfo!.username}"
                                              : "@...",
                                          style: AppTextStyles.body14Regular
                                              .copyWith(
                                                color: AppColors.greyColor,
                                              ),
                                        ),
                                        Text(
                                          settingInfo?.joinedAt != null
                                              ? "Joined ${settingInfo!.joinedAt}"
                                              : "...",
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
                              alignment: AlignmentDirectional.centerEnd,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    AppRoutes.subscriptionView,
                                  );
                                },
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
                                            S.of(context).upgradePro,
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
                        title: S.of(context).viewMyPosts,
                        svgIcon: AppImages.profileIcon,
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.myProfileView);
                        },
                      ),
                      ProfileMenuItem(
                        title: S.of(context).favorites,
                        svgIcon: AppImages.favoriteprofileicon,
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.favoriteView);
                        },
                      ),
                      ProfileMenuItem(
                        title: S.of(context).following,
                        svgIcon: AppImages.following,
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.followingView);
                        },
                      ),
                    ],
                  ),
                  ProfileMenuGroup(
                    children: [
                      ProfileMenuItem(
                        title: S.of(context).freeGenerations,
                        svgIcon: AppImages.aiPoweredIcon,
                        trailing: Padding(
                          padding: EdgeInsetsDirectional.only(end: 8.w),
                          child: Text(
                            "5",
                            style: AppTextStyles.badge14SemiBold,
                          ),
                        ),
                        onTap: () {},
                      ),
                      ProfileMenuItem(
                        title: S.of(context).manageSubscription,
                        svgIcon: AppImages.manageSubscriptions,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.subscriptionView,
                          );
                        },
                      ),
                    ],
                  ),
                  ProfileMenuGroup(
                    children: [
                      ProfileMenuItem(
                        title: S.of(context).support,
                        svgIcon: AppImages.support,
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.supportView);
                        },
                      ),
                      ProfileMenuItem(
                        title:
                            context.watch<LocaleCubit>().state.languageCode ==
                                'en'
                            ? 'العربية'
                            : 'English',
                        svgIcon: AppImages.languageIcon,
                        onTap: () {
                          context.read<LocaleCubit>().toggleLanguage();
                        },
                      ),
                      ProfileMenuItem(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.notificationsView,
                          );
                        },
                        title: S.of(context).notification,
                        svgIcon: AppImages.notifications,
                      ),
                    ],
                  ),
                  ProfileMenuGroup(
                    children: [
                      ProfileMenuItem(
                        title: S.of(context).termsConditions,
                        svgIcon: AppImages.terms,
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.termsView);
                        },
                      ),
                      ProfileMenuItem(
                        title: S.of(context).privacyPolicy,
                        svgIcon: AppImages.privacy,
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.privacyView);
                        },
                      ),
                      ProfileMenuItem(
                        title: S.of(context).security,
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
                        title: S.of(context).share,
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
                        title: S.of(context).logOut,
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
