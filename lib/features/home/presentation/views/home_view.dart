import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/constant/app_images.dart';
import 'package:sammly/core/constant/app_strings.dart';
import 'package:sammly/core/routing/routes.dart';
import 'package:sammly/features/home/presentation/views/widgets/home_header.dart'; // مسار الهيدر بتاعك
import 'package:sammly/features/home/presentation/views/widgets/home_card_widget.dart';
import 'package:sammly/features/generate/presentation/views/image_generation_stepper_view.dart';

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
            colors: [
              AppColors.bg1Color,
              AppColors.whiteColor,
            ],
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
                      title: AppStrings.aiRoomGeneration,
                      description: AppStrings.aiRoomGenerationDesc,
                      imagePath: AppImages.homeGenerationPlaceholder,
                      tagText: AppStrings.aiTag,
                      tagIcon: AppImages.aiPoweredIcon,
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.textToImageGenerateView);
                      },
                    ),
                    
                    HomeCardWidget(
                      title: AppStrings.fullHomeDesign,
                      description: AppStrings.fullHomeDesignDesc,
                      imagePath: AppImages.fullHomePlaceholder,
                      tagText: AppStrings.fullHomeTag,
                      tagIcon: AppImages.fullHomeIcon, 
                      onTap: () {},
                    ),
                    
                    HomeCardWidget(
                      title: AppStrings.roomRedesign,
                      description: AppStrings.roomRedesignDesc,
                      imagePath: AppImages.redesignPlaceholder,
                      tagText: AppStrings.restyleRoomTag,
                      tagIcon: AppImages.restyleIcon, 
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.restyleView);
                      },
                    ),
                    
                    HomeCardWidget(
                      title: AppStrings.maskInpainting,
                      description: AppStrings.maskInpaintingDesc,
                      imagePath: AppImages.homeGenerationPlaceholder,
                      tagText: AppStrings.maskInpaintingTag,
                      tagIcon: AppImages.aiPoweredIcon, 
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ImageGenerationStepperView(),
                          ),
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