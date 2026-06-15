import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/functions.dart';
import 'package:sammly/core/theme/text_styles.dart';
import 'package:sammly/core/widgets/avatar_widget.dart';
import 'package:sammly/features/Explore/cubit/explorecubit.dart';
import 'package:sammly/features/History/presentation/views/historydetails.dart';
import 'package:sammly/features/following/cubit/following_cubit.dart';
import 'package:sammly/features/following/cubit/following_states.dart';
import 'package:sammly/features/following/data/repo/following_repo.dart';
import 'package:sammly/features/following/presentation/widgets/gradient_follow_bottom.dart';
import 'package:sammly/features/profile/data/models/shared_images_model.dart';
import 'package:sammly/features/profile/presentation/views/widgets/posts_data_section.dart';
import 'package:sammly/features/profile/presentation/views/widgets/shared_image_card.dart';

class UserProfileView extends StatefulWidget {
  final String userId;
  final String userName;
  final String? userAvatar;

  const UserProfileView({
    super.key,
    required this.userId,
    required this.userName,
    this.userAvatar,
  });

  @override
  State<UserProfileView> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  bool isFollowing = false;

  @override
  Widget build(BuildContext context) {
    final allDesigns = context.read<ExploreCubit>().currentDesigns;
    final userDesigns = allDesigns
        .where((d) => d.name == widget.userName)
        .toList();

    final int postsCount = userDesigns.length;
    final int likesCount = userDesigns.fold(
      0,
      (sum, item) => sum + item.likesCount,
    );

    return BlocProvider(
      create: (context) => FollowingCubit(FollowingRepo()),
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: Stack(
          children: [
            // Gradient header background
            Container(
              height: 300.h,
              decoration: const BoxDecoration(
                gradient: AppColors.primaryGradient3,
              ),
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
                                  PostsDataSection(
                                    postsCount: postsCount.toString(),
                                    likesCount: likesCount.toString(),
                                  ),
                                  SizedBox(height: 16.h),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: userDesigns.length,
                                    itemBuilder: (context, index) {
                                      final design = userDesigns[index];
                                      final item = SharedImageModel(
                                        title: 'Shared Design',
                                        description: design.prompt,
                                        imageUrl: design.imageUrl,
                                        likes: design.likesCount,
                                      );

                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  HistoryDetailsView(
                                                    title: item.title,
                                                    imageUrl: item.imageUrl,
                                                    designId: design.id,
                                                  ),
                                            ),
                                          );
                                        },
                                        child: SharedImageCard(item: item),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            // User avatar + name + follow button
                            Align(
                              alignment: Alignment.topCenter,
                              child: Column(
                                children: [
                                  AvatarWidget(
                                    avatarPath: widget.userAvatar,
                                    gender: null,
                                    width: 100.w,
                                    height: 100.h,
                                    borderRadius: BorderRadius.circular(16.r),
                                  ),
                                  SizedBox(height: 14.h),
                                  Text(
                                    widget.userName,
                                    style: AppTextStyles.title20Bold,
                                  ),
                                  SizedBox(height: 14.h),
                                  BlocConsumer<FollowingCubit, FollowingState>(
                                    listener: (context, state) {
                                      if (state is FollowSuccess &&
                                          state.userId == widget.userId) {
                                        setState(() {
                                          isFollowing = true;
                                        });
                                        showCustomSnackBar(
                                          context: context,
                                          message: state.message,
                                        );
                                      } else if (state is FollowFailure &&
                                          state.userId == widget.userId) {
                                        showCustomSnackBar(
                                          context: context,
                                          message: state.error,
                                          isError: true,
                                        );
                                      } else if (state is UnfollowSuccess &&
                                          state.userId == widget.userId) {
                                        setState(() {
                                          isFollowing = false;
                                        });
                                        showCustomSnackBar(
                                          context: context,
                                          message: state.message,
                                        );
                                      } else if (state is UnfollowFailure &&
                                          state.userId == widget.userId) {
                                        showCustomSnackBar(
                                          context: context,
                                          message: state.error,
                                          isError: true,
                                        );
                                      }
                                    },
                                    builder: (context, state) {
                                      final isLoading =
                                          (state is FollowLoading &&
                                              state.userId == widget.userId) ||
                                          (state is UnfollowLoading &&
                                              state.userId == widget.userId);

                                      if (isLoading) {
                                        return const CircularProgressIndicator();
                                      }

                                      return GradientFollowButton(
                                        isFollowing: isFollowing,
                                        onFollow: () {
                                          context
                                              .read<FollowingCubit>()
                                              .followUser(widget.userId);
                                        },
                                        onUnfollow: () {
                                          context
                                              .read<FollowingCubit>()
                                              .unfollowUser(widget.userId);
                                        },
                                      );
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
      ),
    );
  }
}
