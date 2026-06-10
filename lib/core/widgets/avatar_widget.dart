import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sammly/core/constant/app_images.dart';
import 'package:sammly/core/networking/api_constants.dart';

/// Widget ذكي لعرض الـ Avatar
/// بيتعامل مع 3 أنواع:
/// 1. data URI (base64) → Image.memory
/// 2. full URL (http/https) → Image.network
/// 3. relative path (uploads/...) → Image.network مع baseUrl
class AvatarWidget extends StatelessWidget {
  final String? avatarPath;
  final double width;
  final double height;
  final BoxFit fit;
  final BorderRadius? borderRadius;

  const AvatarWidget({
    super.key,
    required this.avatarPath,
    required this.width,
    required this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final br = borderRadius ?? BorderRadius.circular(16);

    // لو مفيش avatar أو فاضي → placeholder
    if (avatarPath == null || avatarPath!.isEmpty) {
      return ClipRRect(
        borderRadius: br,
        child: SvgPicture.asset(
          AppImages.maleProfilePlaceholder,
          width: width,
          height: height,
          fit: fit,
        ),
      );
    }

    // 1. لو الـ avatar هو data URI (base64)
    if (avatarPath!.startsWith('data:image')) {
      try {
        final base64Str = avatarPath!.split(',').last;
        final Uint8List bytes = base64Decode(base64Str);
        return ClipRRect(
          borderRadius: br,
          child: Image.memory(
            bytes,
            width: width,
            height: height,
            fit: fit,
            errorBuilder: (context, error, stackTrace) => _placeholder(),
          ),
        );
      } catch (_) {
        return ClipRRect(borderRadius: br, child: _placeholder());
      }
    }

    // 2. لو الـ avatar هو full URL
    if (avatarPath!.startsWith('http://') || avatarPath!.startsWith('https://')) {
      return ClipRRect(
        borderRadius: br,
        child: Image.network(
          avatarPath!,
          width: width,
          height: height,
          fit: fit,
          errorBuilder: (context, error, stackTrace) => _placeholder(),
        ),
      );
    }

    // 3. لو الـ avatar هو relative path (زي uploads/profile-male.png)
    final fullUrl = '${ApiConstants.baseUrl}/$avatarPath';
    return ClipRRect(
      borderRadius: br,
      child: Image.network(
        fullUrl,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) => _placeholder(),
      ),
    );
  }

  Widget _placeholder() {
    return SvgPicture.asset(
      AppImages.maleProfilePlaceholder,
      width: width,
      height: height,
      fit: fit,
    );
  }
}
