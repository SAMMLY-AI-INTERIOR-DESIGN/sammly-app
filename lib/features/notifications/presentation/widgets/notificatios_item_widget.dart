import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/constant/app_strings.dart';
import 'package:sammly/core/theme/text_styles.dart';
import 'package:sammly/core/widgets/custom_heart_item.dart';
import 'package:sammly/core/widgets/avatar_widget.dart';
import 'package:sammly/features/notifications/data/model/notifications_model.dart';

class NotificationItemWidget extends StatelessWidget {
  final NotificationItemModel item;

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
                child: AvatarWidget(
                  avatarPath: item.avatar,
                  gender: null,
                  width: 52.r,
                  height: 52.r,
                  borderRadius: BorderRadius.circular(26.r),
                ),
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
                  item.title,
                  style: AppTextStyles.body16Medium
                ),
                SizedBox(height: 4.h),
                Text(
                  AppStrings.likeYourSharedDesign,
                  style: AppTextStyles.body14Regular.copyWith(
                    color: AppColors.greyColor.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
          
          Text(
            item.createdAt,
            style: AppTextStyles.body14Regular.copyWith(
              color: AppColors.greyColor.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }
}