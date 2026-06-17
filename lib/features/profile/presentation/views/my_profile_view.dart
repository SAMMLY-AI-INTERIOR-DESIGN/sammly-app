import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/features/profile/presentation/views/widgets/posts_data_section.dart';
import 'package:sammly/features/profile/presentation/views/widgets/profile_appbar.dart';
import 'package:sammly/features/profile/presentation/views/widgets/profile_image_name_widget.dart';
import 'package:sammly/features/profile/presentation/views/widgets/shared_images_list_view.dart';

class MyProfileView extends StatefulWidget {
  const MyProfileView({super.key});

  @override
  State<MyProfileView> createState() => _MyProfileViewState();
}

class _MyProfileViewState extends State<MyProfileView> {
  int _postsCount = 0;
  int _likesCount = 0;

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
                            margin: EdgeInsetsDirectional.only(top: 50.h),
                            padding: EdgeInsetsDirectional.only(
                              top: 60.h,
                              start: 16.w,
                              end: 16.w,
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
                                SizedBox(height: 80.h),
                                PostsDataSection(
                                  postsCount: _postsCount.toString(),
                                  likesCount: _likesCount.toString(),
                                ),
                                SizedBox(height: 16.h),

                                SharedImagesListView(
                                  onDataCalculated: (posts, likes) {
                                    if (_postsCount != posts ||
                                        _likesCount != likes) {
                                      setState(() {
                                        _postsCount = posts;
                                        _likesCount = likes;
                                      });
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),

                          const ProfileImageNameWidget(),
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
