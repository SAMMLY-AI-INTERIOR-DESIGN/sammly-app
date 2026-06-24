import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/constant/app_images.dart';
import 'package:sammly/core/widgets/custom_appbar.dart';
import 'package:sammly/core/widgets/custombutton.dart';
import 'package:sammly/core/utils/image_download_helper.dart';
import 'package:sammly/core/routing/routes.dart';
import 'package:sammly/core/widgets/avatar_widget.dart';
import 'package:sammly/features/Explore/cubit/design_details_cubit.dart';
import 'package:sammly/features/Explore/cubit/design_details_states.dart';
import 'package:sammly/features/Explore/cubit/explorecubit.dart';
import 'package:sammly/generated/l10n.dart';
import 'package:sammly/features/Explore/data/design_details_model.dart';
import 'package:sammly/features/Explore/data/exploremodel.dart';
import 'package:sammly/features/favorite/presentation/cubit/favorite_cubit.dart';
import 'package:sammly/features/favorite/presentation/cubit/favorite_state.dart';
import 'package:sammly/features/generate/data/model/generate_mappers.dart';

class SharedDesignDetailsView extends StatefulWidget {
  final ExploreDesignModel exploreDesign;

  const SharedDesignDetailsView({super.key, required this.exploreDesign});

  @override
  State<SharedDesignDetailsView> createState() =>
      _SharedDesignDetailsViewState();
}

class _SharedDesignDetailsViewState extends State<SharedDesignDetailsView> {
  bool _isMaximized = false;

  @override
  void initState() {
    super.initState();
    context.read<DesignDetailsCubit>().fetchDesignDetails(
      widget.exploreDesign.id,
      overrideId: widget.exploreDesign.id,
    );
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
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: isError ? Colors.red : AppColors.primaryColor,
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  String _formatText(String text) {
    if (text.isEmpty) return '';
    return text
        .split('-')
        .map(
          (str) => str.isNotEmpty
              ? '${str[0].toUpperCase()}${str.substring(1)}'
              : '',
        )
        .join(' ');
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !_isMaximized,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        if (_isMaximized) _toggleMaximize();
      },
      child: BlocConsumer<DesignDetailsCubit, DesignDetailsState>(
        listener: (context, state) {
          if (state is DesignShareSuccess) {
            _showSnackbar(state.message);
          } else if (state is DesignCancelShareSuccess) {
            _showSnackbar(state.message);
          } else if (state is DesignLikeSuccess) {
            _showSnackbar(state.message);
            context.read<ExploreCubit>().toggleLikeLocal(
              widget.exploreDesign.id,
            );
          } else if (state is DesignUnlikeSuccess) {
            _showSnackbar(state.message);
            context.read<ExploreCubit>().toggleLikeLocal(
              widget.exploreDesign.id,
            );
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
            return const Scaffold(
              backgroundColor: AppColors.whiteColor,
              body: Center(child: CircularProgressIndicator()),
            );
          }

          if (state is DesignDetailsLoaded) {
            final design = state.design;
            context.read<FavoriteCubit>().syncFavoriteStatus(
              design.id,
              design.isFavorited,
            );
          }

          if (state is DesignDetailsError) {
            return Scaffold(
              backgroundColor: AppColors.whiteColor,
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 48.sp,
                      color: AppColors.greyColor,
                    ),
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
                      onPressed: () =>
                          context.read<DesignDetailsCubit>().fetchDesignDetails(
                            widget.exploreDesign.id,
                            overrideId: widget.exploreDesign.id,
                          ),
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
              ),
            );
          }

          final cubit = context.read<DesignDetailsCubit>();
          if (cubit.currentDesign == null) {
            return Scaffold(
              backgroundColor: AppColors.whiteColor,
              body: Center(child: Text(S.of(context).noDesignDetailsFound)),
            );
          }

          final design = cubit.currentDesign!;

          return Scaffold(
            backgroundColor: AppColors.whiteColor,
            appBar: _isMaximized
                ? null
                : CustomAppbar(
                    title: _formatText(design.room),
                    onBack: _handleBack,
                    actions: [
                      if (cubit.isPublisher)
                        PopupMenuButton<String>(
                          icon: SvgPicture.asset(
                            AppImages.shareIcon,
                            colorFilter: const ColorFilter.mode(
                              AppColors.blackColor,
                              BlendMode.srcIn,
                            ),
                            width: 24.w,
                          ),
                          onSelected: (value) {
                            if (value == 'share') {
                              cubit.shareDesign(widget.exploreDesign.id);
                            } else if (value == 'cancel_share') {
                              cubit.cancelShareDesign(widget.exploreDesign.id);
                            }
                          },
                          itemBuilder: (context) {
                            final isShared = design.isShared;
                            return [
                              PopupMenuItem(
                                value: isShared ? 'cancel_share' : 'share',
                                child: Text(
                                  isShared ? 'Cancel Share' : 'Share Design',
                                ),
                              ),
                            ];
                          },
                        ),
                    ],
                  ),
            body: SafeArea(
              child: BlocListener<FavoriteCubit, FavoriteState>(
                listener: (context, favState) {
                  if (favState is FavoriteToggleSuccess) {
                    _showSnackbar(favState.message);
                  } else if (favState is FavoriteToggleError) {
                    _showSnackbar(favState.message, isError: true);
                  }
                },
                child: _isMaximized
                    ? _buildMaximizedView(design)
                    : _buildNormalView(design, cubit),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNormalView(DesignDetailsModel design, DesignDetailsCubit cubit) {
    final creator = cubit.currentCreator;

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. User Info Header
                if (creator != null)
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.userProfileView,
                        arguments: {
                          'userId': creator.userId,
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
                  'Prompt : ${design.prompt}',
                  style: TextStyle(
                    color: AppColors.blackColor.withValues(alpha: 0.8),
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
                      design.imageUrl.isEmpty
                          ? Container(
                              width: double.infinity,
                              height: 350.h,
                              color: Colors.grey[200],
                              child: const Center(
                                child: Icon(
                                  Icons.broken_image,
                                  color: Colors.grey,
                                ),
                              ),
                            )
                          : Image.network(
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
                                    child: Icon(
                                      Icons.broken_image,
                                      color: Colors.grey,
                                    ),
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
                              Colors.black.withValues(alpha: 0.3),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),

                      // Gradient overlay at bottom for icons
                      PositionedDirectional(
                        bottom: 0,
                        start: 0,
                        end: 0,
                        height: 80.h,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Colors.black.withValues(alpha: 0.3),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                      ),

                      // Bookmark Icon (Favorite)
                      PositionedDirectional(
                        top: 12.h,
                        end: 12.w,
                        child: BlocBuilder<FavoriteCubit, FavoriteState>(
                          builder: (context, favState) {
                            final isFav = context
                                .read<FavoriteCubit>()
                                .isFavorite(design.id);
                            return GestureDetector(
                              onTap: () {
                                context.read<FavoriteCubit>().toggleFavorite(
                                  design.id,
                                  isFav,
                                );
                                context
                                    .read<DesignDetailsCubit>()
                                    .updateFavoriteStatus(!isFav);
                                context
                                    .read<ExploreCubit>()
                                    .toggleFavoriteLocal(
                                      widget.exploreDesign.id,
                                    );
                              },
                              child: isFav
                                  ? SvgPicture.asset(
                                      AppImages.withsaving,
                                      width: 24.w,
                                    ).withAppGradient()
                                  : SvgPicture.asset(
                                      AppImages.withoutsaving,
                                      width: 24.w,
                                    ),
                            );
                          },
                        ),
                      ),

                      // Download Icon (Bottom Left)
                      PositionedDirectional(
                        bottom: 12.h,
                        start: 12.w,
                        child: GestureDetector(
                          onTap: () {
                            if (design.imageUrl.isNotEmpty) {
                              ImageDownloadHelper.downloadNetworkImage(
                                context,
                                design.imageUrl,
                              );
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.all(8.w),
                            decoration: BoxDecoration(
                              color: AppColors.whiteColor.withValues(
                                alpha: 0.85,
                              ),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.2),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: SvgPicture.asset(
                              AppImages.downloadIcon,
                              width: 20.w,
                            ),
                          ),
                        ),
                      ),

                      // Maximize Icon (Bottom Right)
                      PositionedDirectional(
                        bottom: 12.h,
                        end: 12.w,
                        child: GestureDetector(
                          onTap: _toggleMaximize,
                          child: Container(
                            padding: EdgeInsets.all(8.w),
                            decoration: BoxDecoration(
                              color: AppColors.whiteColor.withValues(
                                alpha: 0.85,
                              ),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.2),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
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
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: GestureDetector(
                    onTap: () {
                      cubit.toggleLike(design.id);
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: EdgeInsets.all(6.w),
                          decoration: BoxDecoration(
                            color: design.isLiked
                                ? AppColors.primaryColor.withValues(alpha: 0.1)
                                : Colors.transparent,
                            shape: BoxShape.circle,
                          ),
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            transitionBuilder: (child, animation) =>
                                ScaleTransition(scale: animation, child: child),
                            child: SvgPicture.asset(
                              design.isLiked
                                  ? AppImages.heartFilled
                                  : AppImages.heartOutline,
                              key: ValueKey<bool>(design.isLiked),
                              width: 16.w,
                            ),
                          ),
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
                  ),
                ),

                SizedBox(height: 40.h),
              ],
            ),
          ),
        ),

        // Pinned Bottom Button
        Padding(
          padding: EdgeInsetsDirectional.only(
            start: 20.w,
            end: 20.w,
            bottom: 20.h,
            top: 8.h,
          ),
          child: CustomButton(
            text: S.of(context).restyleThisDesign,
            prefixIcon: AppImages.startGenerateIcon,
            onPressed: () {
              if (design.imageUrl.isNotEmpty) {
                Navigator.pushNamed(
                  context,
                  AppRoutes.restyleView,
                  arguments: {
                    'initialImageUrl': design.imageUrl,
                    'initialStyle': GenerateMappers.styleToUi(design.style),
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMaximizedView(DesignDetailsModel design) {
    return Stack(
      children: [
        Positioned.fill(
          child: design.imageUrl.isEmpty
              ? Container(
                  color: Colors.grey[200],
                  child: const Center(
                    child: Icon(Icons.broken_image, color: Colors.grey),
                  ),
                )
              : Image.network(
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
        PositionedDirectional(
          top: 12.h,
          start: 12.w,
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
                    offset: const Offset(0, 2),
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
        PositionedDirectional(
          bottom: 24.h,
          end: 24.w,
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
                    offset: const Offset(0, 2),
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
        'January',
        'February',
        'March',
        'April',
        'May',
        'June',
        'July',
        'August',
        'September',
        'October',
        'November',
        'December',
      ];
      return '${date.day} ${months[date.month - 1]} ${date.year}';
    } catch (_) {
      return isoDate;
    }
  }
}
