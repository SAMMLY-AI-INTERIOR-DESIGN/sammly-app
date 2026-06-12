import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:sammly/core/constant/app_images.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/widgets/custom_appbar.dart';
import 'package:sammly/core/widgets/action_buttons_row.dart';
import 'package:sammly/features/History/presentation/widgets/history_main_image_section.dart';
import 'package:sammly/features/History/presentation/widgets/history_details_section.dart';
import 'package:sammly/features/favorite/presentation/cubit/favorite_toggle_cubit.dart';
import 'package:sammly/features/favorite/presentation/cubit/favorite_toggle_state.dart';
import 'package:sammly/features/search/presentation/widgets/similar_item_card.dart';
import 'package:sammly/features/search/presentation/views/search_view.dart';

class HistoryDetailsView extends StatefulWidget {
  final String title;
  final String imageUrl;
  final String designId;

  const HistoryDetailsView({
    super.key,
    required this.title,
    required this.imageUrl,
    this.designId = '',
  });

  @override
  State<HistoryDetailsView> createState() => _HistoryDetailsViewState();
}

class _HistoryDetailsViewState extends State<HistoryDetailsView> {
  bool _isMaximized = false;
  bool _isSaved = false;

  final List<SimilarItemModel> products = [
    SimilarItemModel(title: "Sofa", subtitle: "Modern gray", imageUrl: "https://placehold.co/175x94"),
    SimilarItemModel(title: "Sofa Premium", subtitle: "Scandynavian textile", imageUrl: "https://placehold.co/175x94"),
    SimilarItemModel(title: "Sofa Luxury", subtitle: "Velvet fabric", imageUrl: "https://placehold.co/175x94"),
    SimilarItemModel(title: "Sofa Minimalist", subtitle: "Cozy wood feet", imageUrl: "https://placehold.co/175x94"),
  ];

  void _openSmartLens(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      enableDrag: true,
      isScrollControlled: true,
      builder: (context) {
        return SmartLensBottomSheet(dummyItems: products);
      },
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

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return BlocListener<FavoriteToggleCubit, FavoriteToggleState>(
      listener: (context, state) {
        if (state is FavoriteToggleReverted && state.designId == widget.designId) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 2),
            ),
          );
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
              : CustomAppbar(title: widget.title, onBack: _handleBack),
          body: SafeArea(
            child: _isMaximized
                ? _buildMaximizedView(screenHeight, screenWidth)
                : _buildNormalView(),
          ),
        ),
      ),
    );
  }

  /// الوضع العادي: صورة + تفاصيل + أزرار
  /// الوضع العادي: صورة + تفاصيل + أزرار
  Widget _buildNormalView() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // الصورة بالوضع العادي مع زرار القلب وعدسات الذكاء الاصطناعي
          SizedBox(
            height: 320.h,
            width: double.infinity,
            child: Stack(
              children: [
                // 1. كود صاحبك: خصائص الـ Smart Lens والـ Save
                HistoryMainImageSection(
                  imageUrl: widget.imageUrl,
                  isMaximized: false,
                  onToggleMaximize: _toggleMaximize,
                  onSmartLensTap: () => _openSmartLens(context),
                  isSaved: _isSaved,
                  onSaveTap: () {
                    setState(() {
                      _isSaved = !_isSaved;
                    });
                  },
                ),

                // 2. كودك: زرار القلب (Favorite) بالكيوبت
                if (widget.designId.isNotEmpty)
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
              ],
            ),
          ),
          SizedBox(height: 24.h),
          const HistoryDetailsSection(),
          SizedBox(height: 40.h),
          const ActionButtonsRow(),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  /// وضع التكبير: الصورة بتدور 90 درجة وبتملا الشاشة كلها
  /// الـ AnimatedRotation بيعمل حركة "المشي" الجميلة
  Widget _buildMaximizedView(double screenHeight, double screenWidth) {
    // الصورة بتتمدد وبتملا الشاشة بدون دوران - تفضل عمودية زي ما هي
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
