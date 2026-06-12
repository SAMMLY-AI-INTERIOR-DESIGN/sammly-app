import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/theme/text_styles.dart';

// موديل بسيط لتنظيم بيانات المنتجات القادمة من الباك إند
class SimilarItemModel {
  final String title;
  final String subtitle;
  final String imageUrl;

  SimilarItemModel({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
  });
}

class SimilarItemCard extends StatelessWidget {
  final SimilarItemModel item;
  final VoidCallback? onTap;

  const SimilarItemCard({super.key, required this.item, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(width: 1, color: const Color(0x7FACAAAA)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // صورة المنتج
          Image.network(
            item.imageUrl,
            height: 95.h,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              height: 95.h,
              color: AppColors.bg2Color,
              child: const Icon(
                Icons.image_outlined,
                color: AppColors.greyColor,
              ),
            ),
          ),
          // تفاصيل المنتج مع الجراديانت الأنيق من فيجما
          Expanded(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFFE5F6F2), Color(0xFFEBF2FB)],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15.r),
                  bottomRight: Radius.circular(15.r),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: AppTextStyles.body16Medium.copyWith(
                          color: const Color(0xFF2E2E2E),
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        item.subtitle,
                        style: AppTextStyles.body14Regular.copyWith(
                          color: const Color(0xFF5B5B5B),
                          fontSize: 12.sp,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  // زرار السهم الصغير للانتقال لتفاصيل المنتج
                  Align(
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                      onTap: onTap,
                      child: Container(
                        padding: EdgeInsets.all(4.w),
                        decoration: const BoxDecoration(
                          color: AppColors.whiteColor,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.arrow_forward,
                          size: 16.sp,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
