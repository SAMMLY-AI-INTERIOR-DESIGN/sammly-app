import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/theme/text_styles.dart';
import 'package:sammly/generated/l10n.dart';

class GradientFollowButton extends StatefulWidget {
  final VoidCallback onFollow;
  final VoidCallback onUnfollow;
  final bool isFollowing;

  const GradientFollowButton({
    super.key,
    required this.onFollow,
    required this.onUnfollow,
    this.isFollowing = false,
  });

  @override
  State<GradientFollowButton> createState() => _GradientFollowButtonState();
}

class _GradientFollowButtonState extends State<GradientFollowButton> {
  // متغير عشان نتابع المنيو مفتوحة ولا مقفولة
  bool _isMenuOpen = false;

  void _showUnfollowMenu(BuildContext context) async {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;

    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(Offset(0, button.size.height), ancestor: overlay),
        button.localToGlobal(
          button.size.bottomRight(Offset(0, button.size.height)),
          ancestor: overlay,
        ),
      ),
      Offset.zero & overlay.size,
    );

    final double buttonWidth = button.size.width;

    // 1. نقلب السهم لفوق أول ما نضغط
    setState(() {
      _isMenuOpen = true;
    });

    final result = await showMenu<String>(
      context: context,
      position: position,
      color: AppColors.whiteColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      constraints: BoxConstraints(minWidth: buttonWidth, maxWidth: buttonWidth),
      items: [
        PopupMenuItem(
          // 2. قللنا ارتفاع المنيو هنا (تقدر تصغر الرقم لو عايزها أرفع)
          height: 35.h,
          value: 'unfollow',
          padding: EdgeInsets.zero,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.person_remove, color: AppColors.redColor, size: 18.sp),
              SizedBox(width: 8.w),
              Text(
                S.of(context).unfollow,
                style: AppTextStyles.body14Regular.copyWith(
                  color: AppColors.redColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );

    // 3. نرجع السهم لتحت أول ما المنيو تتقفل (سواء اختار حاجة أو داس بره)
    if (mounted) {
      setState(() {
        _isMenuOpen = false;
      });
    }

    if (result == 'unfollow') {
      widget.onUnfollow();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isFollowing) {
      return Container(
        height: 38.h,
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient3,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: ElevatedButton(
          onPressed: () => _showUnfollowMenu(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            elevation: 0,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                S.of(context).following,
                style: AppTextStyles.body16Medium.copyWith(
                  color: AppColors.whiteColor,
                  letterSpacing: 0.5,
                ),
              ),
              SizedBox(width: 6.w),
              // 4. تغيير الأيقونة بناءً على حالة المنيو
              Icon(
                _isMenuOpen
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
                color: AppColors.whiteColor,
                size: 20.sp,
              ),
            ],
          ),
        ),
      );
    }

    // زرار Follow (الوضع العادي)
    return Container(
      height: 38.h,
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient3,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: ElevatedButton(
        onPressed: widget.onFollow,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          elevation: 0,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(2.w),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.add,
                color: AppColors.secondaryColor,
                size: 16.sp,
              ),
            ),
            SizedBox(width: 8.w),
            Text(
              S.of(context).follow,
              style: AppTextStyles.body16Medium.copyWith(
                color: Colors.white,
                fontSize: 15.sp,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
