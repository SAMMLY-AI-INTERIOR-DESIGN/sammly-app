import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/constant/app_images.dart';
import 'package:sammly/core/functions.dart';
import 'package:sammly/core/widgets/custom_appbar.dart';
import 'package:sammly/core/widgets/action_buttons_row.dart';
import 'package:sammly/features/favorite/presentation/cubit/favorite_toggle_cubit.dart';
import 'package:sammly/features/favorite/presentation/cubit/favorite_toggle_state.dart';

class BrowseDesignDetailsView extends StatefulWidget {
  final String imageUrl;
  final String designId;

  const BrowseDesignDetailsView({
    super.key,
    required this.imageUrl,
    required this.designId,
  });

  @override
  State<BrowseDesignDetailsView> createState() =>
      _BrowseDesignDetailsViewState();
}

class _BrowseDesignDetailsViewState extends State<BrowseDesignDetailsView> {
  bool _isMaximized = false;

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

  @override
  Widget build(BuildContext context) {
    return BlocListener<FavoriteToggleCubit, FavoriteToggleState>(
      listener: (context, state) {
        if (state is FavoriteToggleReverted && state.designId == widget.designId) {
          showCustomSnackBar(context: context, message: state.errorMessage, isError: true);
        }
      },
      child: PopScope(
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
                  title: 'Living Room',
                  onBack: _handleBack,
                  actions: [
                    IconButton(
                      icon: Icon(
                        Icons.more_vert,
                        color: AppColors.blackColor,
                        size: 24.sp,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
          body: SafeArea(
            child: _isMaximized ? _buildMaximizedView() : _buildNormalView(),
          ),
        ),
      ),
    );
  }

  /// الوضع العادي: صورة + تفاصيل + أزرار
  Widget _buildNormalView() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Prompt text
          Text(
            'Lorem ipsum dolor sit amet consectetur. Fermentum volutpat praesent purus massa neque leo. Gravida sapien non tristique justo non adipiscing sem nam.',
            style: TextStyle(
              color: AppColors.blackColor.withOpacity(0.8),
              fontSize: 14.sp,
              height: 1.5,
              fontWeight: FontWeight.w400,
              fontFamily: 'Manrope',
            ),
          ),
          SizedBox(height: 20.h),

          // Image Container
          ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: Stack(
              children: [
                Image.network(
                  widget.imageUrl,
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

                // Heart Icon
                Positioned(
                  top: 12.h,
                  right: 12.w,
                  child: BlocBuilder<FavoriteToggleCubit, FavoriteToggleState>(
                    buildWhen: (prev, curr) {
                      if (curr is FavoriteToggleUpdated) {
                        return curr.designId == widget.designId;
                      }
                      if (curr is FavoriteToggleReverted) {
                        return curr.designId == widget.designId;
                      }
                      return false;
                    },
                    builder: (context, state) {
                      final isLiked = context
                          .read<FavoriteToggleCubit>()
                          .isFavorited(widget.designId);

                      return GestureDetector(
                        onTap: () {
                          context
                              .read<FavoriteToggleCubit>()
                              .toggleFavorite(widget.designId);
                        },
                        child: Container(
                          padding: EdgeInsets.all(8.w),
                          decoration: const BoxDecoration(
                            color: AppColors.bg2Color,
                            shape: BoxShape.circle,
                          ),
                          child: SvgPicture.asset(
                            isLiked
                                ? AppImages.heartFilled
                                : AppImages.heartOutline,
                            width: 20.w,
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Maximize Icon
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
          SizedBox(height: 12.h),

          SizedBox(height: 40.h),

          // Bottom Buttons
          const ActionButtonsRow(),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  /// وضع التكبير: الصورة بتملا الشاشة كلها
  Widget _buildMaximizedView() {
    return Stack(
      children: [
        // الصورة مفرودة بالكامل
        Positioned.fill(
          child: Image.network(
            widget.imageUrl,
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
                color: AppColors.whiteColor.withValues(alpha: 0.85),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
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
                    color: Colors.black.withValues(alpha: 0.2),
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
}
