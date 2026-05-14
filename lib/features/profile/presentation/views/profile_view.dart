import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/constant/app_strings.dart';
import 'package:sammly/core/theme/text_styles.dart';
import 'package:sammly/features/profile/presentation/views/widgets/profile_appbar.dart';
import 'package:sammly/features/profile/presentation/views/widgets/profile_data_section.dart';
import 'package:sammly/features/profile/presentation/views/widgets/profile_image_widget.dart';
import 'package:sammly/features/profile/presentation/views/widgets/shared_images_list_view.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Stack(
        children: [
          Container(
            height: 300.h,
            decoration: BoxDecoration(gradient: AppColors.primaryGradient3),
          ),

          SafeArea(
            child: Column(
              children: [

                const ProfileAppBar(),
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
                                ProfileDataSection(),
                                SizedBox(height: 30.h),

                                Text(
                                  AppStrings.sharedImages,
                                  style: AppTextStyles.title18SemiBold,
                                ),
                                SizedBox(height: 16.h),

                                SharedImagesListView(), 
                              ],
                            ),
                          ),

                          const ProfileImageWidget(),
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
