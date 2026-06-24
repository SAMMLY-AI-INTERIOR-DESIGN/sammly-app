import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/functions.dart';
import 'package:sammly/core/theme/text_styles.dart';
import 'package:sammly/core/widgets/avatar_widget.dart';
import 'package:sammly/features/Explore/cubit/public_profile_cubit.dart';
import 'package:sammly/features/Explore/cubit/public_profile_state.dart';
import 'package:sammly/features/Explore/cubit/public_profile_repo.dart';
import 'package:sammly/features/Explore/data/exploremodel.dart';
import 'package:sammly/features/Explore/presentation/views/shared_design_details_view.dart';
import 'package:sammly/features/following/cubit/following_cubit.dart';
import 'package:sammly/features/following/cubit/following_states.dart';
import 'package:sammly/features/following/data/repo/following_repo.dart';
import 'package:sammly/features/following/presentation/widgets/gradient_follow_bottom.dart';
import 'package:sammly/features/profile/data/models/shared_images_model.dart';
import 'package:sammly/features/profile/presentation/views/widgets/posts_data_section.dart';
import 'package:sammly/generated/l10n.dart';
import 'package:sammly/features/profile/presentation/views/widgets/shared_image_card.dart';
import 'package:sammly/features/profile/presentation/cubit/profile_cubit.dart';

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
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PublicProfileCubit(PublicProfileRepo())
            ..getPublicProfile(userId: widget.userId),
        ),
        BlocProvider(
          create: (context) => FollowingCubit(FollowingRepo()),
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: BlocBuilder<PublicProfileCubit, PublicProfileState>(
          builder: (context, state) {
            if (state is PublicProfileLoading || state is PublicProfileInitial) {
              return const Center(
                  child: CircularProgressIndicator(
                      color: AppColors.primaryColor));
            } else if (state is PublicProfileFailure) {
              return Center(child: Text(state.error));
            } else if (state is PublicProfileSuccess) {
              final profileData = state.profileData;
              final postsCount = profileData.stats.totalDesigns;
              final likesCount = profileData.stats.totalLikes;
              final userDesigns = profileData.designs;
              final isFollowing = profileData.isFollowing;

              return Stack(
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
                                    margin: EdgeInsetsDirectional.only(
                                        top: 50.h),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                            final styleText = design.style;
                                            final roomText = design.room;
                                            final combinedTitle = '$styleText $roomText'.trim();
                                            final item = SharedImageModel(
                                              title: combinedTitle.isEmpty ? S.of(context).sharedDesign : combinedTitle,
                                              description: design.prompt,
                                              imageUrl: design.imageUrl,
                                              likes: design.likesCount,
                                              isLiked: design.isLiked,
                                            );

                                            return GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        SharedDesignDetailsView(
                                                      exploreDesign: ExploreDesignModel(
                                                        id: design.id,
                                                        name: profileData.profile.name,
                                                        avatar: profileData.profile.avatar,
                                                        likesCount: design.likesCount,
                                                        prompt: design.prompt,
                                                        imageUrl: design.imageUrl,
                                                        sharedAt: design.sharedAt ?? '',
                                                        isLiked: design.isLiked,
                                                        isFavorited: design.isFavorited,
                                                        style: design.style,
                                                        room: design.room,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: SharedImageCard(
                                                item: item,
                                                onLikeChanged: (isLiked) {
                                                  context
                                                      .read<PublicProfileCubit>()
                                                      .toggleLike(design.id, isLiked);
                                                },
                                              ),
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
                                          avatarPath: profileData.profile.avatar.isNotEmpty
                                              ? profileData.profile.avatar
                                              : widget.userAvatar,
                                          gender: null,
                                          width: 100.w,
                                          height: 100.h,
                                          borderRadius:
                                              BorderRadius.circular(16.r),
                                        ),
                                        SizedBox(height: 14.h),
                                        Text(
                                          profileData.profile.name.isNotEmpty
                                              ? profileData.profile.name
                                              : widget.userName,
                                          style: AppTextStyles.title20Bold,
                                        ),
                                        SizedBox(height: 14.h),
                                        if (context
                                                .read<ProfileCubit>()
                                                .currentProfile
                                                ?.name !=
                                            widget.userName)
                                          BlocConsumer<FollowingCubit,
                                              FollowingState>(
                                            listener: (context, followingState) {
                                              if (followingState is FollowSuccess &&
                                                  followingState.userId ==
                                                      widget.userId) {
                                                context
                                                    .read<PublicProfileCubit>()
                                                    .updateFollowStatus(true);
                                                showCustomSnackBar(
                                                    context: context,
                                                    message:
                                                        followingState.message);
                                              } else if (followingState
                                                      is FollowFailure &&
                                                  followingState.userId ==
                                                      widget.userId) {
                                                showCustomSnackBar(
                                                    context: context,
                                                    message:
                                                        followingState.error,
                                                    isError: true);
                                              } else if (followingState
                                                      is UnfollowSuccess &&
                                                  followingState.userId ==
                                                      widget.userId) {
                                                context
                                                    .read<PublicProfileCubit>()
                                                    .updateFollowStatus(false);
                                                showCustomSnackBar(
                                                    context: context,
                                                    message:
                                                        followingState.message);
                                              } else if (followingState
                                                      is UnfollowFailure &&
                                                  followingState.userId ==
                                                      widget.userId) {
                                                showCustomSnackBar(
                                                    context: context,
                                                    message:
                                                        followingState.error,
                                                    isError: true);
                                              }
                                            },
                                            builder: (context, followingState) {
                                              final isLoading = (followingState
                                                          is FollowLoading &&
                                                      followingState.userId ==
                                                          widget.userId) ||
                                                  (followingState
                                                          is UnfollowLoading &&
                                                      followingState.userId ==
                                                          widget.userId);

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
                                        if (context
                                                .read<ProfileCubit>()
                                                .currentProfile
                                                ?.name ==
                                            widget.userName)
                                          SizedBox(height: 48.h),
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
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
