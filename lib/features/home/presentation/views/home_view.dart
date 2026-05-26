import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sammly/core/constant/app_images.dart';
import 'package:sammly/core/constant/app_strings.dart';
import 'package:sammly/features/home/presentation/views/widgets/home_header.dart'; // مسار الهيدر بتاعك
import 'package:sammly/features/home/presentation/views/widgets/home_card_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA), 
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const HomeHeader(),
              
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
                      onTap: () {},
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
                      onTap: () {},
                    ),
                    
                    SizedBox(height: 24.h), 
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}