import 'package:flutter/material.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/theme/text_styles.dart';
import 'style_card.dart';
import 'package:sammly/generated/l10n.dart';

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
                S.of(context).exploreStyles,
                style: AppTextStyles.title20SemiBold,
              ),
              Text(
                S.of(context).viewAll,
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
            children: [
              StyleCard(
                title: S.of(context).midCenturyModern,
                imageUrl:
                    "https://images.unsplash.com/photo-1600210492486-724fe5c67fb0?auto=format&fit=crop&w=800&q=80",
              ),
              StyleCard(
                title: S.of(context).bohemian,
                imageUrl:
                    "https://images.unsplash.com/photo-1600210492486-724fe5c67fb0?auto=format&fit=crop&w=800&q=80",
              ),
              StyleCard(
                title: S.of(context).rustic,
                imageUrl:
                    "https://images.unsplash.com/photo-1600210492486-724fe5c67fb0?auto=format&fit=crop&w=800&q=80",
              ),
              StyleCard(
                title: S.of(context).coastal,
                imageUrl:
                    "https://images.unsplash.com/photo-1600210492486-724fe5c67fb0?auto=format&fit=crop&w=800&q=80",
              ),
              StyleCard(
                title: S.of(context).traditional,
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
