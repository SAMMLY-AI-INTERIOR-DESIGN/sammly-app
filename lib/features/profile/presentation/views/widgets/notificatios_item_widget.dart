import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/theme/text_styles.dart';
import 'package:sammly/core/widgets/custom_heart_item.dart';
import 'package:sammly/features/profile/data/models/notifications_model.dart';

class NotificationItemWidget extends StatelessWidget {
  final NotificationModel item;

  const NotificationItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              CircleAvatar(
                radius: 26.r,
                backgroundColor: AppColors.bg1Color,
                backgroundImage: NetworkImage(item.imageUrl), 
              ),
              Positioned(
                bottom: 0,
                right: -8.w,
                child: CustomHeartItem(),
              ),
            ],
          ),
          
          SizedBox(width: 16.w),
          
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: AppTextStyles.body16Medium
                ),
                SizedBox(height: 4.h),
                Text(
                  item.action,
                  style: AppTextStyles.body14Regular.copyWith(
                    color: AppColors.greyColor.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
          
          Text(
            item.time,
            style: AppTextStyles.body14Regular.copyWith(
              color: AppColors.greyColor.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }
}