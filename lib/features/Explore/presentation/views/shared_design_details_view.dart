import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/constant/app_images.dart';
import 'package:sammly/core/widgets/custom_appbar.dart';
import 'package:sammly/core/widgets/action_buttons_row.dart';
import 'package:sammly/core/routing/routes.dart';
import 'package:sammly/core/widgets/avatar_widget.dart';
import 'package:sammly/features/Explore/cubit/design_details_cubit.dart';
import 'package:sammly/features/Explore/cubit/design_details_states.dart';
import 'package:sammly/features/favorite/presentation/cubit/favorite_cubit.dart';
import 'package:sammly/features/favorite/presentation/cubit/favorite_state.dart';

class SharedDesignDetailsView extends StatefulWidget {
  final String designId;

  const SharedDesignDetailsView({super.key, required this.designId});

  @override
  State<SharedDesignDetailsView> createState() =>
      _SharedDesignDetailsViewState();
}

class _SharedDesignDetailsViewState extends State<SharedDesignDetailsView> {
  bool _isMaximized = false;

  @override
  void initState() {
    super.initState();
    context.read<DesignDetailsCubit>().fetchDesignDetails(widget.designId);
  }

  void _toggleMaximize() {
    setState(() {
      _isMaximized = !_isMaximized;
    });
  }

  void _handleBack() {
    if (_isMaximized) {
      _toggleMaximize();
    } else {
      Navigator.pop(context);
    }
  }

  void _showSnackbar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : AppColors.primaryColor,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !_isMaximized,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        if (_isMaximized) _toggleMaximize();
      },
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: _isMaximized
            ? null
            : CustomAppbar(
                title: 'Design Details',
                onBack: _handleBack,
                actions: [
                  BlocBuilder<DesignDetailsCubit, DesignDetailsState>(
                    builder: (context, state) {
                      final cubit = context.read<DesignDetailsCubit>();
                      if (cubit.currentDesign == null || !cubit.isPublisher) {
                        return const SizedBox.shrink();
                      }
                      
                      return PopupMenuButton<String>(
                        icon: Icon(
                          Icons.more_vert,
                          color: AppColors.blackColor,
                          size: 24.sp,
                        ),
                        onSelected: (value) {
                          if (value == 'share') {
                            cubit.shareDesign(widget.designId);
                          } else if (value == 'cancel_share') {
                            cubit.cancelShareDesign(widget.designId);
                          }
                        },
                        itemBuilder: (context) {
                          final isShared = cubit.currentDesign!.isShared;
                          return [
                            PopupMenuItem(
                              value: isShared ? 'cancel_share' : 'share',
                              child: Text(isShared ? 'Cancel Share' : 'Share Design'),
                            ),
                          ];
                        },
                      );
                    },
                  ),
                ],
              ),
        body: SafeArea(
          child: BlocConsumer<DesignDetailsCubit, DesignDetailsState>(
            listener: (context, state) {
              if (state is DesignShareSuccess) {
                _showSnackbar(state.message);
              } else if (state is DesignCancelShareSuccess) {
                _showSnackbar(state.message);
              } else if (state is DesignLikeSuccess) {
                _showSnackbar(state.message);
              } else if (state is DesignUnlikeSuccess) {
                _showSnackbar(state.message);
              } else if (state is DesignActionError) {
                _showSnackbar(state.message, isError: true);
              }
            },
            buildWhen: (previous, current) {
              return current is DesignDetailsLoading ||
                  current is DesignDetailsLoaded ||
                  current is DesignDetailsError;
            },
            builder: (context, state) {
              if (state is DesignDetailsLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is DesignDetailsError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline,
                          size: 48.sp, color: AppColors.greyColor),
                      SizedBox(height: 12.h),
                      Text(
                        state.message,
                        style: TextStyle(
                          color: AppColors.greyColor,
                          fontSize: 14.sp,
                          fontFamily: 'Manrope',
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 12.h),
                      TextButton(
                        onPressed: () => context
                            .read<DesignDetailsCubit>()
                            .fetchDesignDetails(widget.designId),
                        child: Text(
                          'Retry',
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 14.sp,
                            fontFamily: 'Manrope',
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }

              final cubit = context.read<DesignDetailsCubit>();
              if (cubit.currentDesign == null) {
                return const Center(child: Text('No design details found'));
              }

              return BlocListener<FavoriteCubit, FavoriteState>(
                listener: (context, favState) {
                  if (favState is FavoriteToggleSuccess) {
                    _showSnackbar(favState.message);
                  } else if (favState is FavoriteToggleError) {
                    _showSnackbar(favState.message, isError: true);
                  }
                },
                child: _isMaximized ? _buildMaximizedView() : _buildNormalView(),
              );
            },
          ),
        ),
      ),
    );
  }

  /// الوضع العادي: صورة + تفاصيل + أزرار
  Widget _buildNormalView() {
    final cubit = context.read<DesignDetailsCubit>();
    final design = cubit.currentDesign!;
    final creator = cubit.currentCreator;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. User Info Header (if not publisher)
          if (creator != null)
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.userProfileView,
                  arguments: {
                    'userName': creator.name,
                    'userAvatar': creator.avatar,
                  },
                );
              },
              child: Row(
                children: [
                  AvatarWidget(
                    avatarPath: creator.avatar,
                    gender: null,
                    width: 48.w,
                    height: 48.w,
                    borderRadius: BorderRadius.circular(24.r),
                  ),
                  SizedBox(width: 12.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        creator.name,
                        style: TextStyle(
                          color: AppColors.blackColor2,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Manrope',
                        ),
                      ),
                      SizedBox(height: 2.h),
                      if (design.sharedAt != null)
                        Text(
                          _formatDate(design.sharedAt!),
                          style: TextStyle(
                            color: AppColors.greyColor,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Manrope',
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          if (creator != null) SizedBox(height: 16.h),

          // 2. Prompt text
          Text(
            design.prompt,
            style: TextStyle(
              color: AppColors.blackColor.withOpacity(0.8),
              fontSize: 14.sp,
              height: 1.5,
              fontWeight: FontWeight.w400,
              fontFamily: 'Manrope',
            ),
          ),
          SizedBox(height: 20.h),

          // 3. Image Container
          ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: Stack(
              children: [
                Image.network(
                  design.imageUrl,
                  width: double.infinity,
                  height: 350.h,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: double.infinity,
                      height: 350.h,
                      color: Colors.grey[200],
                      child: const Center(
                        child: Icon(Icons.broken_image, color: Colors.grey),
                      ),
                    );
                  },
                ),

                // Gradient overlay at top for heart
                Container(
                  height: 80.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.3),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),

                // Gradient overlay at bottom for expand icon
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  height: 80.h,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(0.3),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),

                // Bookmark Icon (Favorite)
                Positioned(
                  top: 12.h,
                  right: 12.w,
                  child: BlocBuilder<FavoriteCubit, FavoriteState>(
                    builder: (context, favState) {
                      final isFav = context.read<FavoriteCubit>().isFavorite(design.id);
                      return GestureDetector(
                        onTap: () {
                          context.read<FavoriteCubit>().toggleFavorite(design.id, isFav);
                        },
                        child: SvgPicture.asset(
                          isFav ? AppImages.withsaving : AppImages.withoutsaving,
                          width: 24.w,
                        ),
                      );
                    },
                  ),
                ),

                // Maximize Icon (Bottom Right)
                Positioned(
                  bottom: 12.h,
                  right: 12.w,
                  child: GestureDetector(
                    onTap: _toggleMaximize,
                    child: Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [AppColors.bg2Color, AppColors.bg1Color],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(
                        AppImages.maximizeimage,
                        width: 20.w,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),

          // 4. Likes Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Like Button
              GestureDetector(
                onTap: () {
                  cubit.toggleLike(design.id);
                },
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(6.w),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(
                        design.isLiked
                            ? AppImages.heartFilled
                            : AppImages.heartOutline,
                        width: 16.w,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      design.isLiked ? 'Liked' : 'Like',
                      style: TextStyle(
                        color: AppColors.greyColor,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Manrope',
                      ),
                    ),
                  ],
                ),
              ),
              // Total Likes
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(6.w),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(AppImages.heartFilled, width: 12.w),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    '${design.likesCount}',
                    style: TextStyle(
                      color: AppColors.greyColor,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Manrope',
                    ),
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: 32.h),

          // Bottom Buttons
          ActionButtonsRow(imageUrl: design.imageUrl),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  /// وضع التكبير: الصورة بتملا الشاشة كلها
  Widget _buildMaximizedView() {
    final design = context.read<DesignDetailsCubit>().currentDesign!;
    return Stack(
      children: [
        // الصورة مفرودة بالكامل
        Positioned.fill(
          child: Image.network(
            design.imageUrl,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.grey[200],
                child: const Center(
                  child: Icon(Icons.broken_image, color: Colors.grey),
                ),
              );
            },
          ),
        ),
        // زرار الرجوع (أعلى يسار)
        Positioned(
          top: 12.h,
          left: 12.w,
          child: GestureDetector(
            onTap: _toggleMaximize,
            child: Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: AppColors.whiteColor.withOpacity(0.85),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: AppColors.blackColor,
                size: 20.sp,
              ),
            ),
          ),
        ),
        // زرار التصغير (ثابت في الزاوية اليمنى السفلية)
        Positioned(
          bottom: 24.h,
          right: 24.w,
          child: GestureDetector(
            onTap: _toggleMaximize,
            child: Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.bg2Color, AppColors.bg1Color],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: SvgPicture.asset(AppImages.minimizeimage, width: 20.w),
            ),
          ),
        ),
      ],
    );
  }

  String _formatDate(String isoDate) {
    try {
      final date = DateTime.parse(isoDate);
      final months = [
        'January', 'February', 'March', 'April', 'May', 'June',
        'July', 'August', 'September', 'October', 'November', 'December'
      ];
      return '${date.day} ${months[date.month - 1]} ${date.year}';
    } catch (_) {
      return isoDate;
    }
  }
}
