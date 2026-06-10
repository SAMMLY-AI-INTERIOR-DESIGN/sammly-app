import 'package:flutter/material.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/constant/app_strings.dart';
import 'package:sammly/core/theme/text_styles.dart';
import 'style_card.dart';

class ExploreStylesSection extends StatelessWidget {
  const ExploreStylesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.exploreStyles,
                style: AppTextStyles.title20SemiBold,
              ),
              Text(
                AppStrings.viewAll,
                style: AppTextStyles.body16Medium.copyWith(
                  color: AppColors.secondaryColor,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 180,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            scrollDirection: Axis.horizontal,
            children: const [
              StyleCard(
                title: "Mid-century modern",
                imageUrl:
                    "https://images.unsplash.com/photo-1600210492486-724fe5c67fb0?auto=format&fit=crop&w=800&q=80",
              ),
              StyleCard(
                title: "Bohemian",
                imageUrl:
                    "https://images.unsplash.com/photo-1600210492486-724fe5c67fb0?auto=format&fit=crop&w=800&q=80",
              ),
              StyleCard(
                title: "Rustic",
                imageUrl:
                    "https://images.unsplash.com/photo-1600210492486-724fe5c67fb0?auto=format&fit=crop&w=800&q=80",
              ),
              StyleCard(
                title: "Coastal",
                imageUrl:
                    "https://images.unsplash.com/photo-1600210492486-724fe5c67fb0?auto=format&fit=crop&w=800&q=80",
              ),
              StyleCard(
                title: "Traditional",
                imageUrl:
                    "https://images.unsplash.com/photo-1600210492486-724fe5c67fb0?auto=format&fit=crop&w=800&q=80",
              ),
            ],
          ),
        ),
      ],
    );
  }
}
