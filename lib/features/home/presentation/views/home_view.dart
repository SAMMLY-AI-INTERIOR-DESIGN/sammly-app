import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/constant/app_images.dart';
import 'package:sammly/core/routing/routes.dart';
import 'package:sammly/features/home/presentation/views/widgets/home_header.dart';
import 'package:sammly/features/home/presentation/views/widgets/home_card_widget.dart';
import 'package:sammly/generated/l10n.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.4, 1.0],
            colors: [AppColors.bg1Color, AppColors.whiteColor],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const HomeHeader(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 8.h),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: Column(
                          children: [
                            HomeCardWidget(
                              title: S.of(context).aiRoomGeneration,
                              description: S.of(context).aiRoomGenerationDesc,
                              imagePath: AppImages.homeGenerationPlaceholder,
                              tagText: S.of(context).aiTag,
                              tagIcon: AppImages.aiPoweredIcon,
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  AppRoutes.textToImageGenerateView,
                                );
                              },
                            ),

                            HomeCardWidget(
                              title: S.of(context).fullHomeDesign,
                              description: S.of(context).fullHomeDesignDesc,
                              imagePath: AppImages.fullHomePlaceholder,
                              tagText: S.of(context).fullHomeTag,
                              tagIcon: AppImages.fullHomeIcon,
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  AppRoutes.fullHomeView,
                                );
                              },
                            ),

                            HomeCardWidget(
                              title: S.of(context).roomRestyle,
                              description: S.of(context).roomRedesignDesc,
                              imagePath: AppImages.redesignPlaceholder,
                              tagText: S.of(context).restyleRoomTag,
                              tagIcon: AppImages.restyleIcon,
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  AppRoutes.restyleView,
                                );
                              },
                            ),

                            HomeCardWidget(
                              title: S.of(context).replace,
                              description: S.of(context).maskInpaintingDesc,
                              imagePath: AppImages.replaceImage,
                              tagText: S.of(context).replaceObject,
                              tagIcon: AppImages.replaceObjectIcon,
                              showCenterIcon: true,
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  AppRoutes.imageGenerationStepperView,
                                );
                              },
                            ),

                            HomeCardWidget(
                              title: S.of(context).remove,
                              description: S.of(context).removeDesc,
                              imagePath: AppImages.removeImage,
                              tagText: S.of(context).removeObject,
                              tagIcon: AppImages.removeObjectIcon,
                              showCenterIcon: true,
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  AppRoutes.removeView,
                                );
                              },
                            ),

                            SizedBox(height: 24.h),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
