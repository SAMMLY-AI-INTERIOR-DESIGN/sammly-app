import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/theme/text_styles.dart';

class CustomHistoryContainer extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final String date;
  final VoidCallback? onTap;

  const CustomHistoryContainer({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.date,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 366.w,
        height: 116.86.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          gradient: const LinearGradient(
            colors: [AppColors.primaryColor, AppColors.secondaryColor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.secondaryColor.withValues(alpha: 0.06),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: EdgeInsets.all(1.2.w), // Acts as border width
        child: Container(
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.bg2Color, AppColors.bg1Color],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(6.r), // inner radius aligned
          ),
          child: Row(
            children: [
              // Thumbnail image
              ClipRRect(
                borderRadius: BorderRadius.circular(5.r),
                child: Image.network(
                  imageUrl,
                  width: 113.w,
                  height: 96.86.h,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 113.w,
                    height: 96.86.h,
                    decoration: BoxDecoration(
                      color: AppColors.bg2Color,
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                    child: Icon(
                      Icons.image_outlined,
                      color: AppColors.secondaryColor,
                      size: 30.sp,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 14.w),

              // Text content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontFamily: AppTextStyles.primaryFont,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.blackColor2,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      description.length > 40
                          ? '${description.substring(0, 40)}........'
                          : description,
                      style: TextStyle(
                        fontFamily: AppTextStyles.primaryFont,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.blackColor.withValues(alpha: 0.7),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.visible,
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      date,
                      style: TextStyle(
                        fontFamily: AppTextStyles.primaryFont,
                        fontSize: 10.1.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.greyColor.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
