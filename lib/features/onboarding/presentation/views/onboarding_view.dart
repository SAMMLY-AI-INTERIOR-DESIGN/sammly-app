import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/constant/app_images.dart';
import 'package:sammly/core/routing/routes.dart';
import 'package:sammly/core/theme/text_styles.dart';
import 'package:sammly/features/onboarding/data/model/inboarding_model.dart';
import 'package:sammly/features/onboarding/presentation/views/widgets/onboarding_item_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:sammly/generated/l10n.dart';

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

  @override
  Widget build(BuildContext context) {
    final List<OnboardingModel> onboardingItems = [
      OnboardingModel(
        title: S.of(context).onboarding1Title,
        subtitle: S.of(context).onboarding1Subtitle,
        imagePath: AppImages.onboarding1,
      ),
      OnboardingModel(
        title: S.of(context).onboarding2Title,
        subtitle: S.of(context).onboarding2Subtitle,
        imagePath: AppImages.onboarding2,
      ),
      OnboardingModel(
        title: S.of(context).onboarding3Title,
        subtitle: S.of(context).onboarding3Subtitle,
        imagePath: AppImages.onboarding3,
      ),
    ];

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
                itemCount: onboardingItems.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPageIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return OnboardingItemWidget(data: onboardingItems[index]);
                },
              ),
            ),

            PositionedDirectional(
              top: screenHeight * 0.06,
              start: 24,
              end: 24,
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
                          S.of(context).back,
                          style: AppTextStyles.hint12Light.copyWith(
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ),
                    ),
                  ),

                  TextButton.icon(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                        context,
                        AppRoutes.layoutView,
                      );
                    },
                    icon: SvgPicture.asset(AppImages.onboardingForward),
                    label: ShaderMask(
                      shaderCallback: (bounds) {
                        return AppColors.primaryGradient.createShader(bounds);
                      },
                      child: Text(
                        S.of(context).skip,
                        style: AppTextStyles.hint12Light.copyWith(
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            PositionedDirectional(
              bottom: 0,
              start: 24,
              end: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: onboardingItems.length,
                    effect: WormEffect(
                      dotHeight: 4,
                      dotWidth: 20,
                      spacing: 6,
                      activeDotColor: AppColors.primaryColor,
                      dotColor: AppColors.activeNavBarBg,
                      paintStyle: PaintingStyle.stroke,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (_currentPageIndex < onboardingItems.length - 1) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        Navigator.pushReplacementNamed(
                          context,
                          AppRoutes.layoutView,
                        );
                      }
                    },
                    child: Stack(
                      children: [
                        SvgPicture.asset(AppImages.onboardingContainer),

                        PositionedDirectional(
                          bottom: 55,
                          end: 30,
                          child: SvgPicture.asset(AppImages.arrowBack),
                        ),
                      ],
                    ),
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
