import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/constant/app_strings.dart';
import 'package:sammly/core/theme/text_styles.dart';
import 'package:sammly/core/routing/routes.dart';
import 'package:sammly/features/profile/data/models/followings_model.dart';

class FollowingItemWidget extends StatefulWidget {
  final FollowingModel item;
  final VoidCallback onUnfollowTap;

  const FollowingItemWidget({
    super.key,
    required this.item,
    required this.onUnfollowTap,
  });

  @override
  State<FollowingItemWidget> createState() => _FollowingItemWidgetState();
}

class _FollowingItemWidgetState extends State<FollowingItemWidget> {
  bool isFollowing = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h), 
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          Navigator.pushNamed(
            context,
            AppRoutes.userProfileView,
            arguments: {
              'userName': widget.item.name,
              'userAvatar': widget.item.imageUrl,
            },
          );
        },
        child: Row(
          children: [
          CircleAvatar(
            radius: 22.r,
            backgroundColor: AppColors.bg1Color,
            backgroundImage: NetworkImage(widget.item.imageUrl),
          ),
          
          SizedBox(width: 12.w),
          
          Expanded(
            child: Text(
              widget.item.name,
              style: AppTextStyles.body16Medium,
            ),
          ),
          
          InkWell(
            onTap: () {
              setState(() {
                isFollowing = !isFollowing;
              });
              if (!isFollowing) {
                 widget.onUnfollowTap();
              }
            },
            borderRadius: BorderRadius.circular(20.r),
            child: isFollowing
              ? Container(
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
                )
              : Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient3,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.add_circle, 
                        color: Colors.white,
                        size: 16.sp,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        AppStrings.follow,
                        style: AppTextStyles.body14Regular.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
          ),
        ],
      ),
    ),
    );
  }
}