import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/theme/text_styles.dart';

class ProfileMenuItem extends StatelessWidget {
  final String title;
  final String svgIcon;
  final IconData? iconData;
  final Widget? trailing;
  final Color? textColor;
  final VoidCallback? onTap;

  const ProfileMenuItem({
    super.key,
    required this.title,
    required this.svgIcon,
    this.iconData,
    this.trailing,
    this.textColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
        child: Row(
          children: [
            SvgPicture.asset(svgIcon, width: 20.w),

            SizedBox(width: 12.w),

            Expanded(child: Text(title, style: AppTextStyles.body16Medium)),

            trailing ??
                Icon(
                  Icons.arrow_forward_ios,
                  size: 20.sp,
                  color: AppColors.blackColor2,
                ),
          ],
        ),
      ),
    );
  }
}
