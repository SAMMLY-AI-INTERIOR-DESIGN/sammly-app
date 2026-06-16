import 'package:flutter/material.dart';
import 'package:sammly/core/theme/text_styles.dart';
import 'package:sammly/features/onboarding/data/model/inboarding_model.dart';

class OnboardingItemWidget extends StatelessWidget {
  final OnboardingModel data;

  const OnboardingItemWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            SizedBox(height: constraints.maxHeight * 0.08),

            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Image.asset(data.imagePath),
              ),
            ),

            const SizedBox(height: 24),

            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      data.title,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.heading24SemiBold.copyWith(
                        color: Color(0xff2E2E2E),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      data.subtitle,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.body16Regular,
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
