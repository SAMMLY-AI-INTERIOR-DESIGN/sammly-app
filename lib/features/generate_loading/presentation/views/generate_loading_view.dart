import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/constant/app_images.dart';
import 'package:sammly/core/functions.dart';
import 'package:sammly/core/routing/routes.dart';
import 'package:sammly/core/theme/text_styles.dart';
import 'package:sammly/features/generate/data/repo/generate_design_repo.dart';
import 'package:sammly/features/generate_loading/presentation/cubits/loading_cubit.dart';
import 'package:sammly/features/generate_loading/presentation/cubits/loading_states.dart';
import 'package:sammly/features/home/logic/home_cubit.dart';
import 'package:sammly/generated/l10n.dart';

class GenerationLoadingWrapper extends StatelessWidget {
  final Map<String, dynamic>? arguments;
  const GenerationLoadingWrapper({super.key, this.arguments});

  // Loading screen assets
  final List<String> images = const [
    AppImages.generateLoading1,
    AppImages.generateLoading2,
    AppImages.generateLoading3,
    AppImages.generateLoading4,
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = GenerationCubit();

        // Extract arguments passed from the generate view
        final style = arguments?['style'] as String? ?? '';
        final room = arguments?['room'] as String? ?? '';
        final prompt = arguments?['prompt'] as String? ?? '';
        final imageUrl = arguments?['imageUrl'] as String?;

        final isRestyle = arguments?['isRestyle'] as bool? ?? false;
        final isFullHome = arguments?['isFullHome'] as bool? ?? false;
        final isMask = arguments?['isMask'] as bool? ?? false;

        if (isMask) {
          final operationMode =
              arguments?['operationMode'] as String? ?? 'replace';
          final maskUrl = arguments?['maskUrl'] as String? ?? '';
          cubit.startMaskWithApi(
            imageUrl: imageUrl ?? '',
            maskUrl: maskUrl,
            prompt: prompt,
            operationMode: operationMode,
            repo: GenerateDesignRepo(),
          );
        } else if (isRestyle) {
          cubit.startRestyleWithApi(
            uiStyle: style,
            imageUrl: imageUrl ?? '',
            repo: GenerateDesignRepo(),
          );
        } else if (isFullHome) {
          final roomTypes = arguments?['roomTypes'] as List<String>? ?? [];
          cubit.startFullHomeWithApi(
            uiStyle: style,
            uiRoomTypes: roomTypes,
            imageUrl: imageUrl,
            repo: GenerateDesignRepo(),
          );
        } else {
          cubit.startLoadingWithApi(
            uiStyle: style,
            uiRoom: room,
            prompt: prompt,
            imageUrl: imageUrl,
            repo: GenerateDesignRepo(),
          );
        }

        return cubit;
      },
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: BlocConsumer<GenerationCubit, GenerationState>(
              listener: (context, state) {
                if (state is GenerationFinished) {
                  context.read<HomeCubit>().fetchHomeData();
                  final showListView =
                      arguments?['showListView'] as bool? ?? false;
                  final bool isFromStepper = arguments?['isMask'] == true;

                    Navigator.pushReplacementNamed(
                      context,
                      AppRoutes.generateResultView,
                      arguments: {
                        'showListView': showListView,
                        'imageUrl': state.imageUrl,
                        'designId': state.designId,
                        'designs': state.designs,
                        'originalImageUrl': arguments?['imageUrl'],
                        'isFromStepper': isFromStepper,
                        'operationMode': arguments?['operationMode'],
                        'style': arguments?['style'],
                        'room': arguments?['room'],
                      },
                    );
                } else if (state is GenerationFailed) {
                  showCustomSnackBar(
                    context: context,
                    message: state.errorMsg,
                    isError: true,
                  );
                  Navigator.pop(context);
                }
              },
              builder: (context, state) {
                int currentStep = 0;
                if (state is GenerationLoadingStep) {
                  currentStep = state.stepIndex;
                }

                final List<String> titles = [
                  S.of(context).yourRoomIsComingSoon,
                  S.of(context).yourRoomIsComingSoon,
                  S.of(context).addingDetails,
                  S.of(context).addingDetails,
                ];

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),

                    // Animated loading image
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      child: SvgPicture.asset(
                        images[currentStep],
                        key: ValueKey<int>(currentStep),
                        height: 80.h,
                        fit: BoxFit.contain,
                      ),
                    ),

                    SizedBox(height: 12.h),

                    // Animated loading text
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

                    // Disclaimer text
                    Text(
                      S.of(context).loadingDisclaimer,
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
