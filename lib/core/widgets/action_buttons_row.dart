import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sammly/core/constant/app_images.dart';
import 'package:sammly/core/widgets/custom_action_button.dart';

class ActionButtonsRow extends StatelessWidget {
  final VoidCallback? onCustomize;
  final VoidCallback? onShare;
  final VoidCallback? onDownload;

  const ActionButtonsRow({
    super.key,
    this.onCustomize,
    this.onShare,
    this.onDownload,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: CustomActionButton(
            title: 'Customize',
            iconPath: AppImages.customizeIcon,
            onTap: onCustomize ?? () {},
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: CustomActionButton(
            title: 'Share',
            iconPath: AppImages.shareIcon,
            onTap: onShare ?? () {},
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: CustomActionButton(
            title: 'Download',
            iconPath: AppImages.downloadIcon,
            onTap: onDownload ?? () {},
          ),
        ),
      ],
    );
  }
}
