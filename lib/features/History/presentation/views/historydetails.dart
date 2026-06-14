import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sammly/core/constant/app_images.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/widgets/custom_appbar.dart';
import 'package:sammly/core/widgets/action_buttons_row.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sammly/features/favorite/presentation/cubit/favorite_cubit.dart';
import 'package:sammly/features/favorite/presentation/cubit/favorite_state.dart';
import 'package:sammly/features/History/presentation/widgets/history_main_image_section.dart';
import 'package:sammly/features/History/presentation/widgets/history_details_section.dart';
import 'package:sammly/features/smart_lens/cubit/search_cubit.dart';
import 'package:sammly/features/smart_lens/data/repo/search_repo.dart';
import 'package:sammly/features/smart_lens/presentation/widgets/smart_lens_bottom_sheet.dart';

class HistoryDetailsView extends StatefulWidget {
  final String title;
  final String imageUrl;
  final String designId;

  const HistoryDetailsView({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.designId,
  });

  @override
  State<HistoryDetailsView> createState() => _HistoryDetailsViewState();
}

class _HistoryDetailsViewState extends State<HistoryDetailsView> {
  bool _isMaximized = false;

  @override
  void initState() {
    super.initState();
    // context.read<FavoriteCubit>().isFavorite(widget.designId) is used directly in the build method.
  }

  void _openSmartLens(BuildContext context) {
    if (widget.designId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Design ID not available for this item."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      enableDrag: true,
      isScrollControlled: true,
      builder: (context) {
        return BlocProvider(
          create: (_) => SearchCubit(SearchRepo()),
          child: SmartLensBottomSheet(designId: widget.designId),
        );
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

    return PopScope(
      canPop: !_isMaximized,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        if (_isMaximized) _toggleMaximize();
      },
      child: BlocListener<FavoriteCubit, FavoriteState>(
        listener: (context, state) {
          if (state is FavoriteToggleSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: AppColors.primaryColor),
            );
          } else if (state is FavoriteToggleError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: Colors.red),
            );
          }
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
  Widget _buildNormalView() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // الصورة بالوضع العادي (بدون دوران)
          SizedBox(
            height: 320.h,
            width: double.infinity,
            child: BlocBuilder<FavoriteCubit, FavoriteState>(
              builder: (context, state) {
                final isSaved = context.read<FavoriteCubit>().isFavorite(widget.designId);
                return HistoryMainImageSection(
                  imageUrl: widget.imageUrl,
                  isMaximized: false,
                  onToggleMaximize: _toggleMaximize,
                  onSmartLensTap: () => _openSmartLens(context),
                  isSaved: isSaved,
                  onSaveTap: () {
                    context.read<FavoriteCubit>().toggleFavorite(widget.designId, isSaved);
                  },
                );
              },
            ),
          ),
          SizedBox(height: 24.h),
          const HistoryDetailsSection(),
          SizedBox(height: 40.h),
          ActionButtonsRow(imageUrl: widget.imageUrl),
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
