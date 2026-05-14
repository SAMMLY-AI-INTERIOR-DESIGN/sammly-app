import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/constant/app_images.dart';
import 'package:sammly/core/constant/app_strings.dart';
import 'package:sammly/core/theme/text_styles.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Container(
        height: 45,
        decoration: BoxDecoration(
          color: AppColors.searchTextFieldColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 4,
              spreadRadius: 3,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: TextField(
          textAlignVertical: TextAlignVertical
              .center, 
          decoration: InputDecoration(
            isDense:
                true, 
            hintText: AppStrings.searchHint,
            hintStyle: AppTextStyles.body16Regular,
            prefixIcon: Padding(
              padding: const EdgeInsets.only(
                left: 12.0,
                right: 8.0,
              ), 
              child: SvgPicture.asset(
                AppImages.searchIcon,
                width: 18,
                height: 18,
              ),
            ),
            prefixIconConstraints: const BoxConstraints(
              minWidth: 40,
              minHeight: 0,
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 12,
            ),
          ),
        ),
      ),
    );
  }
}
