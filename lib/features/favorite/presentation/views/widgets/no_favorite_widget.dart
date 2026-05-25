import 'package:flutter/material.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/constant/app_images.dart';
import 'package:sammly/core/constant/app_strings.dart';
import 'package:sammly/core/theme/text_styles.dart';

class NoFavoriteWidget extends StatelessWidget {
  const NoFavoriteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AppImages.noFavorite),
          Text(AppStrings.noFavorites, style: AppTextStyles.title20Bold),
          Text(
            AppStrings.noFavoritesDesc,
            style: AppTextStyles.body16Regular.copyWith(
              color: AppColors.greyColor.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
    );
  }
}
