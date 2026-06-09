import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sammly/core/constant/app_images.dart';
import 'package:sammly/core/constant/app_strings.dart';
import 'package:sammly/core/routing/routes.dart';
import 'package:sammly/core/widgets/custom_appbar.dart';
import 'package:sammly/features/generate/presentation/views/widgets/custom_stepper.dart';
import 'package:sammly/features/generate/presentation/views/widgets/step_1_upload.dart';
import 'package:sammly/features/generate/presentation/views/widgets/text_to_image_step_2_style.dart';

class RestyleView extends StatefulWidget {
  const RestyleView({super.key});

  @override
  State<RestyleView> createState() => _RestyleViewState();
}

class _RestyleViewState extends State<RestyleView> {
  int _currentStep = 0;
  String? _selectedStyle;
  XFile? _selectedImage;

  void _nextStep() {
    if (_currentStep < 1) {
      setState(() {
        _currentStep++;
      });
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: _currentStep == 0
            ? AppStrings.uploadRoom
            : AppStrings.selectStyle,
        onBack: _previousStep,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 80.w),
            child: CustomStepper(
              currentStep: _currentStep,
              stepTitles: const [AppStrings.upload, AppStrings.style],
            ),
          ),
          Expanded(
            child: _currentStep == 0
                ? Step1Upload(
                  title: AppStrings.uploadReferenceImage,
                    subtitle: AppStrings.addReferenceImageOnly,
                    initialImage: _selectedImage,
                    onImageSelected: (image) {
                      setState(() {
                        _selectedImage = image;
                      });
                    },
                    onImageRemoved: () {
                      setState(() {
                        _selectedImage = null;
                      });
                    },
                    onNext: _nextStep,
                  )
                : TextToImageStep2Style(
                    selectedStyle: _selectedStyle,
                    onStyleSelected: (style) {
                      setState(() {
                        _selectedStyle = style;
                      });
                    },
                    onNext: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.generateLoadingView,
                        arguments: {'showListView': false},
                      );
                    },
                    buttonText: AppStrings.restyleYourSpace,
                    buttonPrefixIcon: AppImages.startGenerateIcon,
                  ),
          ),
        ],
      ),
    );
  }
}
