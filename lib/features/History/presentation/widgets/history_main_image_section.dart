import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/constant/app_images.dart';

class HistoryMainImageSection extends StatelessWidget {
  final String imageUrl;
  final bool isMaximized;
  final VoidCallback onToggleMaximize;

  const HistoryMainImageSection({
    super.key,
    required this.imageUrl,
    required this.isMaximized,
    required this.onToggleMaximize,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(isMaximized ? 0 : 16.r),
      child: Stack(
        children: [
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
                    )
                  ],
                ),
                child: SvgPicture.asset(
                  isMaximized ? AppImages.minimizeimage : AppImages.maximizeimage,
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