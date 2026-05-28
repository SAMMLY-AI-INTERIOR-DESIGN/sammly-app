import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/constant/app_images.dart';
import 'package:sammly/core/theme/text_styles.dart';
import 'package:sammly/features/profile/presentation/views/widgets/gradient_follow_bottom.dart';
import 'package:sammly/features/profile/presentation/views/widgets/posts_data_section.dart';
import 'package:sammly/features/profile/presentation/views/widgets/shared_images_list_view.dart';

class UserProfileView extends StatelessWidget {
  final String userName;
  final String? userAvatar;

  const UserProfileView({
    super.key,
    required this.userName,
    this.userAvatar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Stack(
        children: [
          // Gradient header background
          Container(
            height: 300.h,
            decoration: const BoxDecoration(gradient: AppColors.primaryGradient3),
          ),

          SafeArea(
            child: Column(
              children: [
                // AppBar
                AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  scrolledUnderElevation: 0,
                  centerTitle: true,
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      color: AppColors.whiteColor,
                      size: 24.sp,
                    ),
                    onPressed: () {
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                    },
                  ),
                  title: Text(
                    userName,
                    style: AppTextStyles.title20Bold
                        .copyWith(color: AppColors.whiteColor),
                  ),
                ),
                SizedBox(height: 20.h),

                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 50.h),
                            padding: EdgeInsets.only(
                              top: 60.h,
                              left: 16.w,
                              right: 16.w,
                              bottom: 20.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16.r),
                                topRight: Radius.circular(16.r),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 110.h),
                                PostsDataSection(),
                                SizedBox(height: 16.h),
                                SharedImagesListView(),
                              ],
                            ),
                          ),

                          // User avatar + name + follow button
                          Align(
                            alignment: Alignment.topCenter,
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(16.r),
                                  child: userAvatar != null
                                      ? Image.network(
                                          userAvatar!,
                                          width: 100.w,
                                          height: 100.h,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  SvgPicture.asset(
                                            AppImages.maleProfilePlaceholder,
                                            width: 100.w,
                                            height: 100.h,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : SvgPicture.asset(
                                          AppImages.maleProfilePlaceholder,
                                          width: 100.w,
                                          height: 100.h,
                                          fit: BoxFit.cover,
                                        ),
                                ),
                                SizedBox(height: 14.h),
                                Text(
                                  userName,
                                  style: AppTextStyles.title20Bold,
                                ),
                                SizedBox(height: 14.h),
                                GradientFollowButton(
                                  onPressed: () {
                                    // TODO: implement follow/unfollow
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
