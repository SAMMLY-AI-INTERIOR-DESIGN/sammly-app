import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sammly/core/constant/app_images.dart';
import 'package:sammly/core/theme/text_styles.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/features/home/presentation/views/widgets/home_tag_widget.dart';

class HomeCardWidget extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final String tagText;
  final String tagIcon;
  final VoidCallback onTap;

  final bool showCenterIcon;

  const HomeCardWidget({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.tagText,
    required this.tagIcon,
    required this.onTap,
    this.showCenterIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsetsDirectional.only(bottom: 20.h),
        decoration: BoxDecoration(
          color: AppColors.bg1Color,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16.r),
                  ),
                  child: Image.asset(
                    imagePath,
                    height: 160.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

                PositionedDirectional(
                  top: 12.h,
                  start: 12.w,
                  child: HomeTagWidget(text: tagText, iconPath: tagIcon),
                ),

                if (showCenterIcon)
                  SvgPicture.asset(
                    AppImages.replaceRemoveIcon,
                    width: 24.w,
                    height: 24.h,
                  ),
              ],
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Column(
                children: [
                  Text(
                    title,
                    style: AppTextStyles.title18SemiBold.copyWith(
                      color: AppColors.blackColor2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    description,
                    style: AppTextStyles.body14Regular.copyWith(
                      color: Colors.grey.shade600,
                      height: 1.4,
                    ),
                    textAlign: TextAlign.center,
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
