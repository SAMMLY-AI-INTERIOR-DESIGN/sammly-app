import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/constant/app_images.dart';
import 'package:sammly/core/theme/text_styles.dart';
import 'package:sammly/generated/l10n.dart';

class ResultImageWidget extends StatefulWidget {
  final String imagePath;
  final bool isNetworkImage;
  final VoidCallback? onSmartLensTap;
  final String? originalImagePath;

  const ResultImageWidget({
    super.key,
    required this.imagePath,
    this.isNetworkImage = false,
    this.onSmartLensTap,
    this.originalImagePath,
  });

  @override
  State<ResultImageWidget> createState() => _ResultImageWidgetState();
}

class _ResultImageWidgetState extends State<ResultImageWidget> {
  bool _showOriginal = false;

  @override
  Widget build(BuildContext context) {
    final imageProvider = widget.isNetworkImage
        ? NetworkImage(widget.imagePath) as ImageProvider
        : AssetImage(widget.imagePath);

    return Container(
      width: double.infinity,
      height: 400.h,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.r)),
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: widget.originalImagePath != null
                ? Stack(
                    fit: StackFit.expand,
                    children: [
                      Image(image: imageProvider, fit: BoxFit.fill),
                      AnimatedOpacity(
                        opacity: _showOriginal ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 300),
                        child: Image.file(
                          File(widget.originalImagePath!),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ],
                  )
                : Image(image: imageProvider, fit: BoxFit.fill),
          ),
          PositionedDirectional(
            top: 16.h,
            start: 16.w,
            child: GestureDetector(
              onTap: widget.onSmartLensTap,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.r),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.3),
                        width: 1.5,
                      ),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(AppImages.smartLensIcon),
                        SizedBox(width: 8.w),
                        Text(
                          S.of(context).smartLens,
                          style: AppTextStyles.badge14SemiBold.copyWith(
                            color: Colors.white,
                            fontSize: 16.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          PositionedDirectional(
            bottom: 16.h,
            start: 16.w,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.3),
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        AppImages.aiPoweredIcon,
                        width: 16.w,
                        height: 16.h,
                        colorFilter: const ColorFilter.mode(
                          AppColors.whiteColor,
                          BlendMode.srcIn,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        S.of(context).generatedBySammly,
                        style: AppTextStyles.body16Medium.copyWith(
                          color: AppColors.whiteColor,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (widget.originalImagePath != null)
            PositionedDirectional(
              bottom: 16.h,
              end: 16.w,
              child: GestureDetector(
                onTapDown: (_) => setState(() => _showOriginal = true),
                onTapUp: (_) => setState(() => _showOriginal = false),
                onTapCancel: () => setState(() => _showOriginal = false),
                child: SvgPicture.asset(
                  AppImages.switchImageIcon,
                  width: 28.w,
                  height: 28.h,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
