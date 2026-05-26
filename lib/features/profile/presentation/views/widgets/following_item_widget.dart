import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/constant/app_strings.dart';
import 'package:sammly/core/theme/text_styles.dart';
import 'package:sammly/features/profile/data/models/followings_model.dart';

class FollowingItemWidget extends StatelessWidget {
  final FollowingModel item;
  final VoidCallback onUnfollowTap;

  const FollowingItemWidget({
    super.key,
    required this.item,
    required this.onUnfollowTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h), 
      child: Row(
        children: [
          CircleAvatar(
            radius: 22.r,
            backgroundColor: AppColors.bg1Color,
            backgroundImage: NetworkImage(item.imageUrl),
          ),
          
          SizedBox(width: 12.w),
          
          Expanded(
            child: Text(
              item.name,
              style: AppTextStyles.body16Medium,
            ),
          ),
          
          InkWell(
            onTap: onUnfollowTap,
            borderRadius: BorderRadius.circular(20.r),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.redColor, width: 1.5),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.remove_circle, 
                    color: AppColors.redColor,
                    size: 16.sp,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    AppStrings.unfollow,
                    style: AppTextStyles.body14Regular.copyWith(
                      color: AppColors.redColor,
                      fontWeight: FontWeight.w500,
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