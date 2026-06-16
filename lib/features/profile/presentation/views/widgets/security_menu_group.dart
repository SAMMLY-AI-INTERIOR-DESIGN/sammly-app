import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sammly/core/constant/app_colors.dart';

class SecurityMenuGroup extends StatelessWidget {
  final List<Widget> children;

  const SecurityMenuGroup({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: AppColors.textFieldBodyColor,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        mainAxisSize:
            MainAxisSize.min, // 💡 دي اللي هتلم خلفية شاشة الـ Security
        children: List.generate(children.length, (index) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              children[index],
              if (index < children.length - 1)
                Divider(
                  height: 0,
                  thickness: 1,
                  color: AppColors.greyColor.withValues(alpha: 0.3),
                  indent: 16.w,
                  endIndent: 16.w,
                ),
            ],
          );
        }),
      ),
    );
  }
}
