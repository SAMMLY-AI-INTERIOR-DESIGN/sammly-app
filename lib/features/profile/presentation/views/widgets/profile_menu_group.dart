import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sammly/core/constant/app_colors.dart';

class ProfileMenuGroup extends StatelessWidget {
  final List<Widget> children;

  const ProfileMenuGroup({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: AppColors.textFieldBodyColor,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: List.generate(children.length, (index) {
          return Column(
            children: [
              children[index],
              if (index < children.length - 1)
                Divider(
                  height: 1,
                  thickness: 1,
                  color: AppColors.greyColor,
                  indent: 45.w,
                  endIndent: 16.w,
                ),
            ],
          );
        }),
      ),
    );
  }
}
