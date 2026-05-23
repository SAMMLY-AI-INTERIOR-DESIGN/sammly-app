import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sammly/core/constant/app_images.dart';
import 'package:sammly/core/theme/text_styles.dart';
import 'package:sammly/features/profile/presentation/views/widgets/gradient_follow_bottom.dart';

class ProfileImageNameWidget extends StatelessWidget {
  const ProfileImageNameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: SvgPicture.asset(
              AppImages.maleProfilePlaceholder,
              width: 100.w,
              height: 100.h,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 14.h,),
          Text("Fatma Salah", style: AppTextStyles.title20Bold),
          SizedBox(height: 14.h,),
          GradientFollowButton(onPressed: () {
            
          },)
        ],
      ),
    );
  }
}
