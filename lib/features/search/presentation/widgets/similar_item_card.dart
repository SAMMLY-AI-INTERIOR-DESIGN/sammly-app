import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/constant/app_images.dart';
import 'package:sammly/core/theme/text_styles.dart';

// موديل بسيط لتنظيم بيانات المنتجات القادمة من الباك إند
class SimilarItemModel {
  final String title;
  final String subtitle;
  final String imageUrl;
  final String? productUrl;

  SimilarItemModel({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    this.productUrl,
  });
}

class SimilarItemCard extends StatelessWidget {
  final SimilarItemModel item;
  final VoidCallback? onTap;

  const SimilarItemCard({super.key, required this.item, this.onTap});

  Future<void> _launchProductUrl() async {
    if (item.productUrl == null || item.productUrl!.isEmpty) return;
    final uri = Uri.parse(item.productUrl!);
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      debugPrint('Could not launch $uri: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? _launchProductUrl,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(width: 1, color: const Color(0x7FACAAAA)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // صورة المنتج (تأخذ المساحة الأكبر)
            Expanded(
              child: item.imageUrl.isEmpty
                  ? Container(
                      width: double.infinity,
                      color: AppColors.bg2Color,
                      child: const Icon(
                        Icons.image_outlined,
                        color: AppColors.greyColor,
                      ),
                    )
                  : Image.network(
                      item.imageUrl,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: double.infinity,
                        color: AppColors.bg2Color,
                        child: const Icon(
                          Icons.image_outlined,
                          color: AppColors.greyColor,
                        ),
                      ),
                    ),
            ),
            // تفاصيل المنتج مع الجراديانت الأنيق من فيجما
            Container(
              width: double.infinity,
              height: 56.h,
              padding: EdgeInsets.symmetric(horizontal: 12.w),
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
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      item.title,
                      style: AppTextStyles.body16Medium.copyWith(
                        color: const Color(0xFF2E2E2E),
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  // أيقونة السهم
                  SvgPicture.asset(
                    AppImages.goArrow,
                    width: 24.w,
                    height: 24.w,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
