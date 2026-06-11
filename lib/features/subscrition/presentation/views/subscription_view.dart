import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/constant/app_images.dart';
import 'package:sammly/core/theme/text_styles.dart';
import 'package:sammly/features/subscrition/presentation/views/widgets/custom_plan.dart';

class SubscriptionView extends StatefulWidget {
  const SubscriptionView({super.key});

  @override
  State<SubscriptionView> createState() => _SubscriptionViewState();
}

class _SubscriptionViewState extends State<SubscriptionView> {
  int _selectedPlanIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Column(
        children: [
          // Scrollable content
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Background Image + Logo + Title
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // Background image - show full, not zoomed
                      ShaderMask(
                        shaderCallback: (rect) {
                          return const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.black, Colors.transparent],
                            stops: [0.5, 1.0],
                          ).createShader(
                            Rect.fromLTRB(0, 0, rect.width, rect.height),
                          );
                        },
                        blendMode: BlendMode.dstIn,
                        child: Image.asset(
                          AppImages.subscriptionBgPlaceholder,
                          fit: BoxFit.fitWidth,
                          width: double.infinity,
                        ),
                      ),

                      // Back button
                      Positioned(
                        top: MediaQuery.of(context).padding.top + 10,
                        left: 20,
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.85),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.1),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.arrow_back_ios_new,
                              color: AppColors.blackColor,
                              size: 20,
                            ),
                          ),
                        ),
                      ),

                      // Logo + Title overlay at bottom of image
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Column(
                          children: [
                            SvgPicture.asset(AppImages.splash, height: 90),
                            Text(
                              "SAMMLY Pro",
                              style: AppTextStyles.heading28ExtraBold.copyWith(
                                color: Colors.black,
                                fontSize: 32,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Pick the perfect plan to bring your\ndream spaces to life",
                              textAlign: TextAlign.center,
                              style: AppTextStyles.body16Regular.copyWith(
                                color: const Color(0xFF2E2E2E),
                                height: 1.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Plans list
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        CustomPlan(
                          iconPath: AppImages.starIcon,
                          title: "Starter",
                          tokensAmount: "50",
                          generationsText: "10 premium generations",
                          description: "Great for starters",
                          price: "EGP 150",
                          priceSub: "/Pack",
                          primaryColor: const Color(0xFF3C60B6),
                          bgColor: const Color(0xFFF1F4FA),
                          borderColor: const Color(0xFFC0CBE7),
                          isSelected: _selectedPlanIndex == 0,
                          onTap: () => setState(() => _selectedPlanIndex = 0),
                        ),

                        CustomPlan(
                          iconPath: AppImages.crownIcon,
                          title: "Pro",
                          tokensAmount: "150",
                          generationsText: "30 premium generations",
                          description: "Great for starters",
                          price: "EGP 370",
                          priceSub: "/Pack",
                          primaryColor: const Color(0xFF23B5A0),
                          bgColor: const Color(0xFFEAFAF7),
                          isSelected: _selectedPlanIndex == 1,
                          onTap: () => setState(() => _selectedPlanIndex = 1),
                        ),

                        CustomPlan(
                          iconPath: AppImages.diamondIcon,
                          title: "Premium",
                          tokensAmount: "500",
                          generationsText: "100 premium generations",
                          description: "Great for starters",
                          price: "EGP 955",
                          priceSub: "/Pack",
                          primaryColor: const Color(0xFF8B5CF6),
                          bgColor: const Color(0xFFF5F0FF),
                          isSelected: _selectedPlanIndex == 2,
                          onTap: () => setState(() => _selectedPlanIndex = 2),
                        ),

                        CustomPlan(
                          iconPath: AppImages.giftIcon,
                          title: "Free Generations",
                          tokensAmount: "25",
                          generationsText: "5 generations",
                          description:
                              "Perfect way to try SAMMLY and\nexplore premium features",
                          price: "Free",
                          primaryColor: const Color(0xFFD97706),
                          bgColor: const Color(0xFFFFFBEB),
                          isFree: true,
                          isSelected: _selectedPlanIndex == 3,
                          onTap: () => setState(() => _selectedPlanIndex = 3),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),

          // Fixed Subscribe Button at bottom
          Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: MediaQuery.of(context).padding.bottom + 16,
              top: 12,
            ),
            child: Container(
              width: double.infinity,
              height: 56,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient3,
                borderRadius: BorderRadius.circular(16),
              ),
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Implement Subscribe Action
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  "Subscribe",
                  style: AppTextStyles.title20Bold.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
