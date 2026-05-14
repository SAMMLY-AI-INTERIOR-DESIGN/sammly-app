import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sammly/core/constant/app_images.dart';

class ProfileImageWidget extends StatelessWidget {
  const ProfileImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: SvgPicture.asset(
          AppImages.maleProfilePlaceholder,
          width: 100.w,
          height: 100.h,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
