import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sammly/core/constant/app_images.dart';

class Loginwith extends StatelessWidget {
  final VoidCallback? onGoogleTap;
  final VoidCallback? onFacebookTap;
  final VoidCallback? onAppleTap;

  const Loginwith({
    super.key,
    this.onGoogleTap,
    this.onFacebookTap,
    this.onAppleTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // استخدام مسارات الصور من الكلاس بتاعك
        _socialIcon(AppImages.googleicon, onGoogleTap),
        SizedBox(width: 25.w),
        _socialIcon(AppImages.facebookicon, onFacebookTap),
        SizedBox(width: 25.w),
        _socialIcon(AppImages.appleicon, onAppleTap),
      ],
    );
  }

  Widget _socialIcon(String path, VoidCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50.h,
        width: 50.w,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: SvgPicture.asset(
            path,
            height: 24.h,
            width: 24.w,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}