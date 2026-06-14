import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sammly/core/constant/app_images.dart';
import 'package:sammly/core/utils/image_download_helper.dart';
import 'package:sammly/core/routing/routes.dart';
import 'package:sammly/core/widgets/custom_action_button.dart';

class ExploreActionButtonsRow extends StatelessWidget {
  final VoidCallback? onTryStyle;
  final VoidCallback? onDownload;
  final String? imageUrl;

  const ExploreActionButtonsRow({
    super.key,
    this.onTryStyle,
    this.onDownload,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: CustomActionButton(
            title: 'Try this Style',
            iconPath: AppImages.startGenerateIcon,
            onTap: onTryStyle ?? () {
              if (imageUrl != null && imageUrl!.isNotEmpty) {
                Navigator.pushNamed(
                  context,
                  AppRoutes.restyleView,
                  arguments: {
                    'initialImageUrl': imageUrl,
                  },
                );
              }
            },
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: CustomActionButton(
            title: 'Download',
            iconPath: AppImages.downloadIcon,
            onTap: onDownload ?? () {
              if (imageUrl != null && imageUrl!.isNotEmpty) {
                ImageDownloadHelper.downloadNetworkImage(context, imageUrl!);
              }
            },
          ),
        ),
      ],
    );
  }
}
