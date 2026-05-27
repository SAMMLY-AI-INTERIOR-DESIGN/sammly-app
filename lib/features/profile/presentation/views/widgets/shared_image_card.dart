import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/constant/app_images.dart';
import 'package:sammly/core/theme/text_styles.dart';
import 'package:sammly/features/profile/data/models/shared_images_model.dart';

class SharedImageCard extends StatefulWidget {
  final SharedImageModel item;
  const SharedImageCard({super.key, required this.item});

  @override
  State<SharedImageCard> createState() => _SharedImageCardState();
}

class _SharedImageCardState extends State<SharedImageCard> {
  bool _isLiked = false;
  late int _likesCount;

  @override
  void initState() {
    super.initState();
    _likesCount = widget.item.likes;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 366.w,
      height: 135.h,
      margin: EdgeInsets.only(bottom: 12.h),
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
          borderRadius: BorderRadius.circular(6.r),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5.r),
              child: Image.network(
                widget.item.imageUrl,
                width: 113.w,
                height: 112.h,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 113.w,
                  height: 112.h,
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

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.item.title,
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
                    widget.item.description.length > 40
                        ? '${widget.item.description.substring(0, 40)}........'
                        : widget.item.description,
                    style: TextStyle(
                      fontFamily: AppTextStyles.primaryFont,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.blackColor.withValues(alpha: 0.7),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.visible,
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _isLiked = !_isLiked;
                                _isLiked ? _likesCount++ : _likesCount--;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(6.w),
                              decoration: BoxDecoration(
                                color: AppColors.bg2Color,
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: SvgPicture.asset(
                                _isLiked
                                    ? AppImages.heartFilled
                                    : AppImages.heartOutline,
                                width: 12.w,
                                height: 12.h,
                              ),
                            ),
                          ),
                          Text(
                            " $_likesCount",
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
