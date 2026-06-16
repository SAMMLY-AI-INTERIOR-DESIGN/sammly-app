import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/theme/text_styles.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({
    super.key,
    required this.title,
    this.actions,
    this.backgroundColor = Colors.transparent,
    this.onBack,
    this.showLeading = true,
  });

  final String title;
  final List<Widget>? actions;
  final Color backgroundColor;
  final VoidCallback? onBack;
  final bool showLeading;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      automaticallyImplyLeading: false,
      leading: showLeading
          ? IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: AppColors.blackColor2,
                size: 25.sp,
              ),
              onPressed: onBack ?? () => Navigator.pop(context),
            )
          : null,
      title: Text(title, style: AppTextStyles.title20Bold),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
