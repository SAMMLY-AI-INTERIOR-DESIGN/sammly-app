import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/constant/app_images.dart';
import 'package:sammly/core/constant/app_strings.dart';
import 'package:sammly/core/routing/routes.dart';
import 'package:sammly/core/theme/text_styles.dart';
import 'package:sammly/features/onboarding/data/model/inboarding_model.dart';
import 'package:sammly/features/onboarding/presentation/views/widgets/onboarding_item_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  late final PageController _pageController;
  int _currentPageIndex = 0;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final List<OnboardingModel> _onboardingItems = [
    const OnboardingModel(
      title: AppStrings.onboarding1Title,
      subtitle: AppStrings.onboarding1Subtitle,
      imagePath: AppImages.onboarding1,
    ),
    const OnboardingModel(
      title: AppStrings.onboarding2Title,
      subtitle: AppStrings.onboarding2Subtitle,
      imagePath: AppImages.onboarding2,
    ),
    const OnboardingModel(
      title: AppStrings.onboarding3Title,
      subtitle: AppStrings.onboarding3Subtitle,
      imagePath: AppImages.onboarding3,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(gradient: AppColors.scafoldBgGradient),
        child: Stack(
          children: [
            Positioned.fill(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _onboardingItems.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPageIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return OnboardingItemWidget(data: _onboardingItems[index]);
                },
              ),
            ),

            Positioned(
              top: screenHeight * 0.06,
              left: 24,
              right: 24,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AnimatedOpacity(
                    opacity: _currentPageIndex > 0 ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 300),
                    child: TextButton.icon(
                      onPressed: _currentPageIndex > 0
                          ? () {
                              _pageController.previousPage(
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.easeInOut,
                              );
                            }
                          : null,
                      icon: SvgPicture.asset(AppImages.onboardingBack),
                      label: ShaderMask(
                        shaderCallback: (bounds) {
                          return AppColors.primaryGradient.createShader(bounds);
                        },
                        child: Text(
                          AppStrings.back,
                          style: AppTextStyles.hint12Light.copyWith(
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ),
                    ),
                  ),

                  TextButton.icon(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, AppRoutes.layoutView);
                    },
                    icon: SvgPicture.asset(AppImages.onboardingForward),
                    label: ShaderMask(
                      shaderCallback: (bounds) {
                        return AppColors.primaryGradient.createShader(bounds);
                      },
                      child: Text(
                        AppStrings.skip,
                        style: AppTextStyles.hint12Light.copyWith(
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Positioned(
              bottom: 0,
              left: 24,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: _onboardingItems.length,
                    effect: WormEffect(
                      dotHeight: 4,
                      dotWidth: 20,
                      spacing: 6,
                      activeDotColor: AppColors.primaryColor,
                      dotColor: AppColors.activeNavBarBg,
                      paintStyle: PaintingStyle.stroke,
                    ),
                  ),
                  Stack(
                    children: [
                      SvgPicture.asset(AppImages.onboardingContainer),

                      Positioned(
                        bottom: 55,
                        right: 30,
                        child: GestureDetector(
                          onTap: () {
                            if (_currentPageIndex < _onboardingItems.length - 1) {
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.easeInOut,
                              );
                            } else {
                              Navigator.pushReplacementNamed(context, AppRoutes.layoutView);
                            }
                          },
                          child: SvgPicture.asset(AppImages.arrowBack),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
