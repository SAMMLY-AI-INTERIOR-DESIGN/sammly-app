import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/constant/app_strings.dart';
import 'package:sammly/core/constant/app_images.dart';
import 'package:sammly/core/theme/text_styles.dart';
import 'package:sammly/core/routing/routes.dart';
import 'package:sammly/features/generate_loading/presentation/cubits/loading_cubit.dart';
import 'package:sammly/features/generate_loading/presentation/cubits/loading_states.dart';

class GenerationLoadingWrapper extends StatelessWidget {
  final Map<String, dynamic>? arguments;
  const GenerationLoadingWrapper({super.key, this.arguments});

  // جهزنا الداتا بالترتيب اللي هتظهر بيه
  final List<String> images = const [
    AppImages.generateLoading1,
    AppImages.generateLoading2,
    AppImages.generateLoading3,
    AppImages.generateLoading4,
  ];

  final List<String> titles = const [
    AppStrings.yourRoomIsComingSoon,
    AppStrings.yourRoomIsComingSoon, // لو التانية نفس النص زي ما في الديزاين
    AppStrings.addingDetails,
    AppStrings.addingDetails,
  ];

  @override
  Widget build(BuildContext context) {
    // استخدمنا BlocProvider عشان نكريت الكيوبت ونشغل الدالة أول ما الشاشة تفتح
    return BlocProvider(
      create: (context) => GenerationCubit()..startLoadingCycle(),
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: BlocConsumer<GenerationCubit, GenerationState>(
              listener: (context, state) {
                if (state is GenerationFinished) {
                  // final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
                  // final showListView = args?['showListView'] as bool? ?? false;
                  Navigator.pushReplacementNamed(
                    context, 
                    AppRoutes.generateResultView, 
                    arguments: arguments,
                  );
                }
              },
              builder: (context, state) {
                // بنجيب رقم الخطوة، ولو لسه بيبدأ نعتبرها 0
                int currentStep = 0;
                if (state is GenerationLoadingStep) {
                  currentStep = state.stepIndex;
                }

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    
                    // 1. الصورة بتتغير حسب الـ currentStep
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500), // أنيميشن خفيف لما الصورة تتغير
                      child: SvgPicture.asset(
                        images[currentStep],
                        key: ValueKey<int>(currentStep), // مهم عشان الأنيميشن يشتغل
                        height: 80.h,
                        fit: BoxFit.contain,
                      ),
                    ),
                    
                    SizedBox(height: 12.h),
                    
                    // 2. النص بيتغير حسب الـ currentStep
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      child: Text(
                        titles[currentStep],
                        key: ValueKey<int>(currentStep),
                        textAlign: TextAlign.center,
                        style: AppTextStyles.title18SemiBold.copyWith(
                          color: AppColors.blackColor,
                        ),
                      ),
                    ),
                    
                    const Spacer(),
                    
                    // 3. النص الثابت
                    Text(
                      AppStrings.loadingDisclaimer,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.body14Regular.copyWith(
                        color: Colors.grey.shade500,
                        height: 1.5,
                      ),
                    ),
                    
                    SizedBox(height: 40.h),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}