import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/constant/app_images.dart';
import 'package:sammly/core/constant/app_strings.dart';
import 'package:sammly/core/theme/text_styles.dart';

class HistoryMainImageSection extends StatelessWidget {
  final String imageUrl;
  final bool isMaximized;
  final VoidCallback onToggleMaximize;
  final VoidCallback? onSmartLensTap;
  final bool isSaved;
  final VoidCallback? onSaveTap;

  const HistoryMainImageSection({
    super.key,
    required this.imageUrl,
    required this.isMaximized,
    required this.onToggleMaximize,
    this.onSmartLensTap,
    this.isSaved = false,
    this.onSaveTap,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(isMaximized ? 0 : 16.r),
      child: Stack(
        children: [
          // Smart Lens Badge (Top Left)
          if (!isMaximized)
            Positioned(
              top: 12.h,
              left: 12.w,
              child: GestureDetector(
                onTap: onSmartLensTap,
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
                            AppStrings.smartLens,
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
            child: Image.network(
              imageUrl,
              fit: isMaximized ? BoxFit.contain : BoxFit.cover,
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
          if (!isMaximized)
            Positioned(
              top: 12.h,
              right: 12.w,
              child: GestureDetector(
                onTap: onSaveTap,
                child: SvgPicture.asset(
                  isSaved
                      ? AppImages.withsaving
                      : AppImages.withoutsaving,
                  width: 24.w,
                ),
              ),
            ),

          // زرار التحكم (تعديل الـ Padding عشان وقت اللاندسكيب ميزنوقش في الحافة)
          Positioned(
            bottom: isMaximized ? 24.h : 12.h,
            right: isMaximized ? 24.w : 12.w,
            child: GestureDetector(
              onTap: onToggleMaximize,
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
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: SvgPicture.asset(
                  isMaximized
                      ? AppImages.minimizeimage
                      : AppImages.maximizeimage,
                  width: 20.w,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
