import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/constant/app_strings.dart';
import 'package:sammly/core/theme/text_styles.dart';

class GradientFollowButton extends StatefulWidget {
  final VoidCallback onPressed;

  const GradientFollowButton({
    super.key,
    required this.onPressed,
  });

  @override
  State<GradientFollowButton> createState() => _GradientFollowButtonState();
}

class _GradientFollowButtonState extends State<GradientFollowButton> {
  bool isFollowing = false;

  void _showUnfollowMenu(BuildContext context) async {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(Offset(0, button.size.height), ancestor: overlay),
        button.localToGlobal(button.size.bottomRight(Offset(0, button.size.height)), ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );

    final result = await showMenu<String>(
      context: context,
      position: position,
      color: AppColors.whiteColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      items: [
        PopupMenuItem(
          value: 'unfollow',
          child: Row(
            children: [
              Icon(Icons.person_remove, color: AppColors.redColor, size: 20.sp),
              SizedBox(width: 8.w),
              Text('Unfollow', style: AppTextStyles.body14Regular.copyWith(color: AppColors.redColor)),
            ],
          ),
        ),
      ],
    );

    if (result == 'unfollow') {
      setState(() {
        isFollowing = false;
      });
      widget.onPressed();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isFollowing) {
      return Container(
        height: 38.h,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.secondaryColor, width: 1.5),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: ElevatedButton(
          onPressed: () => _showUnfollowMenu(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            elevation: 0,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Following',
                style: AppTextStyles.body16Medium.copyWith(
                  color: AppColors.secondaryColor,
                  fontSize: 15.sp,
                  letterSpacing: 0.5,
                ),
              ),
              SizedBox(width: 6.w),
              Icon(Icons.keyboard_arrow_down, color: AppColors.secondaryColor, size: 20.sp),
            ],
          ),
        ),
      );
    }

    return Container(
      height: 38.h, // ارتفاع مناسب لزرار الـ Follow
      decoration: BoxDecoration(
        // الجرادينت الرأسي من الأزرق للأخضر
        gradient: AppColors.primaryGradient3,
        borderRadius: BorderRadius.circular(8.r), // حواف دائرية خفيفة
      ),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            isFollowing = true;
          });
          widget.onPressed();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent, // عشان الجرادينت يبان
          shadowColor: Colors.transparent,
          elevation: 0,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min, // عشان الزرار ياخد مساحة المحتوى بس
          children: [
            // 1. الدايرة البيضا اللي جواها علامة (+)
            Container(
              padding: EdgeInsets.all(2.w),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.add,
                color: AppColors.secondaryColor, // علامة الزائد بلون أخضر/Teal
                size: 16.sp,
              ),
            ),
            
            SizedBox(width: 8.w),
            
            // 2. كلمة Follow
            Text(
              AppStrings.follow,
              style: AppTextStyles.body16Medium.copyWith(
                color: Colors.white,
                fontSize: 15.sp,
                letterSpacing: 0.5, // مسافة خفيفة بين الحروف
              ),
            ),
          ],
        ),
      ),
    );
  }
}