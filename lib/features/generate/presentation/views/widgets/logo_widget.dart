import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sammly/core/constant/app_images.dart';
import 'package:sammly/core/theme/text_styles.dart';
import 'package:sammly/generated/l10n.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        SvgPicture.asset(AppImages.splash, height: 140.h, width: 180.w),
        PositionedDirectional(
          bottom: -5.h,
          child: Text(
            S.of(context).appdesc,
            style: AppTextStyles.title15extraBold,
          ),
        ),
      ],
    );
  }
}
