import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/constant/app_images.dart';
import 'package:sammly/core/theme/text_styles.dart';
import 'package:sammly/features/profile/data/model/shared_images_model.dart';
import 'package:sammly/core/widgets/custom_heart_item.dart';
class SharedImageCard extends StatelessWidget {
  final SharedImageModel item;
  const SharedImageCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(1),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient3,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Container( 
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: SvgPicture.asset(
                item.imageUrl, 
                width: 80.w, 
                height: 80.h, 
                fit: BoxFit.cover
              ),
            ),
            SizedBox(width: 12.w),
            
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: AppTextStyles.title18SemiBold,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis, 
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    item.description,
                    style: AppTextStyles.body14Regular,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis, 
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CustomHeartItem(),
                          Text(
                            " ${item.likes}",
                            style: AppTextStyles.body16Medium,
                          ),
                        ],
                      ),
                      SvgPicture.asset(
                        AppImages.goArrow,
                        width: 20.w,
                        height: 20.h,
                      ),
                    ],
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