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
        _socialIcon(AppImages.googleicon, onGoogleTap),
        SizedBox(width: 40.w), // 💡 زودنا المسافة هنا لـ 40 عشان البراح
        _socialIcon(AppImages.facebookicon, onFacebookTap),
        SizedBox(width: 40.w), // 💡 وزودنا المسافة هنا كمان
        _socialIcon(AppImages.appleicon, onAppleTap),
      ],
    );
  }

  Widget _socialIcon(String path, VoidCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      // 💡 شيلنا الـ Container بالـ BoxDecoration تماماً
      // واعتمدنا على الأيقونة بشكل مباشر
      child: SvgPicture.asset(
        path,
        height: 38.h, // كبرنا الحجم شوية لتعويض غياب الإطار
        width: 38.w,
        fit: BoxFit.contain,
      ),
    );
  }
}