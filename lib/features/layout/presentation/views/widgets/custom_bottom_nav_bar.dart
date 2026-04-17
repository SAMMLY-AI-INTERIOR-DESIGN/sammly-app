import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/constant/app_images.dart';
import 'package:sammly/core/constant/app_strings.dart';
import 'package:sammly/core/theme/text_styles.dart';


class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        gradient: AppColors.navBgGradient,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.secondaryColor.withValues(alpha: 0.3),
            offset: const Offset(0, 4),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(0, AppImages.homeIcon, AppStrings.home),
          _buildNavItem(1, AppImages.exploreIcon, AppStrings.explore),
          _buildNavItem(2, AppImages.historyIcon, AppStrings.history),
          _buildNavItem(3, AppImages.profileIcon, AppStrings.profile),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, String imageIcon, String label) {
    final isSelected = currentIndex == index;
    return GestureDetector(
      onTap: () => onTap(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: isSelected
            ? const EdgeInsets.symmetric(horizontal: 16, vertical: 8)
            : const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.activeNavBarBg : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              imageIcon,
            ),
            if (isSelected && label.isNotEmpty) ...[
              const SizedBox(width: 8),
              ShaderMask(
                shaderCallback: (bounds) {
                  return AppColors.primaryGradient.createShader(bounds);
                },
                child: Text(
                  label,
                  style: AppTextStyles.body16Regular.copyWith(
                    color: AppColors.whiteColor
                  ),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
