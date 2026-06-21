import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/constant/app_images.dart';
import 'package:sammly/core/theme/text_styles.dart';
import 'package:sammly/generated/l10n.dart';

class HistoryMainImageSection extends StatefulWidget {
  final String imageUrl;
  final bool isMaximized;
  final VoidCallback onToggleMaximize;
  final VoidCallback? onSmartLensTap;
  final bool? isSaved;
  final VoidCallback? onSaveTap;
  final String? originalImagePath;

  const HistoryMainImageSection({
    super.key,
    required this.imageUrl,
    required this.isMaximized,
    required this.onToggleMaximize,
    this.onSmartLensTap,
    this.isSaved,
    this.onSaveTap,
    this.originalImagePath,
  });

  @override
  State<HistoryMainImageSection> createState() =>
      _HistoryMainImageSectionState();
}

class _HistoryMainImageSectionState extends State<HistoryMainImageSection> {
  bool _showOriginal = false;

  @override
  Widget build(BuildContext context) {
    final displayUrl = _showOriginal && widget.originalImagePath != null
        ? widget.originalImagePath!
        : widget.imageUrl;

    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.isMaximized ? 0 : 16.r),
      child: Stack(
        children: [
          // Smart Lens Badge (Top Left)
          if (!widget.isMaximized)
            PositionedDirectional(
              top: 12.h,
              start: 12.w,
              child: GestureDetector(
                onTap: widget.onSmartLensTap,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.r),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.3),
                          width: 1.5,
                        ),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(AppImages.smartLensIcon),
                          SizedBox(width: 8.w),
                          Text(
                            S.of(context).smartLens,
                            style: AppTextStyles.badge14SemiBold.copyWith(
                              color: Colors.white,
                              fontSize: 16.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          // الصورة مفرودة ومحجّمة بشكل ممتاز
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: displayUrl.isEmpty
                ? Container(
                    color: Colors.grey[200],
                    child: const Center(
                      child: Icon(Icons.broken_image, color: Colors.grey),
                    ),
                  )
                : Image.network(
                    displayUrl,
                    fit: widget.isMaximized ? BoxFit.contain : BoxFit.cover,
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

          // Bookmark Save Icon (Top Right)
          if (!widget.isMaximized)
            PositionedDirectional(
              top: 12.h,
              end: 12.w,
              child: widget.isSaved == null
                  ? SizedBox(
                      width: 24.w,
                      height: 24.w,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.primaryColor,
                      ),
                    )
                  : GestureDetector(
                      onTap: widget.onSaveTap,
                      child: SvgPicture.asset(
                        widget.isSaved! ? AppImages.withsaving : AppImages.withoutsaving,
                        width: 24.w,
                      ),
                    ),
            ),

          // زرار التحكم (تعديل الـ Padding عشان وقت اللاندسكيب ميزنوقش في الحافة)
          PositionedDirectional(
            bottom: widget.isMaximized ? 24.h : 12.h,
            end: widget.isMaximized ? 24.w : 12.w,
            child: GestureDetector(
              onTap: widget.onToggleMaximize,
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
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: SvgPicture.asset(
                  widget.isMaximized
                      ? AppImages.minimizeimage
                      : AppImages.maximizeimage,
                  width: 20.w,
                ),
              ),
            ),
          ),
          
          // Switch image button (bottom-end, to the left of the maximize button)
          if (widget.originalImagePath != null && widget.originalImagePath!.isNotEmpty)
            PositionedDirectional(
              bottom: widget.isMaximized ? 24.h : 12.h,
              end: widget.isMaximized ? 64.w : 52.w,
              child: GestureDetector(
                onTapDown: (_) => setState(() => _showOriginal = true),
                onTapUp: (_) => setState(() => _showOriginal = false),
                onTapCancel: () => setState(() => _showOriginal = false),
                child: SvgPicture.asset(
                  AppImages.switchImageIcon,
                  width: 28.w,
                  height: 28.h,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
