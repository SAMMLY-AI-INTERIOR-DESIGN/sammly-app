import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sammly/core/constant/app_images.dart';
import 'package:sammly/core/utils/image_download_helper.dart';
import 'package:sammly/core/widgets/custom_action_button.dart';
import 'package:sammly/generated/l10n.dart';

class GenerateActionButtonsRow extends StatelessWidget {
  final VoidCallback? onEdit;
  final VoidCallback? onShare;
  final VoidCallback? onDownload;
  final String? imageUrl;
  final bool isShared;

  const GenerateActionButtonsRow({
    super.key,
    this.onEdit,
    this.onShare,
    this.onDownload,
    this.imageUrl,
    this.isShared = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: CustomActionButton(
            title: S.of(context).editBtn,
            iconPath: AppImages.edit,
            onTap: onEdit ?? () {},
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: CustomActionButton(
            title: isShared ? S.of(context).shared : S.of(context).share,
            iconPath: AppImages.postIcon,
            onTap: onShare ?? () {},
            isDisabled: isShared,
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: CustomActionButton(
            title: S.of(context).downloadBtn,
            iconPath: AppImages.downloadIcon,
            onTap:
                onDownload ??
                () {
                  if (imageUrl != null && imageUrl!.isNotEmpty) {
                    ImageDownloadHelper.downloadNetworkImage(
                      context,
                      imageUrl!,
                    );
                  }
                },
          ),
        ),
      ],
    );
  }
}
