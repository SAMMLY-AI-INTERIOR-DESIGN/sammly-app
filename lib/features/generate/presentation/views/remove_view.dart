import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sammly/core/constant/app_strings.dart';
import 'package:sammly/core/routing/routes.dart';
import 'package:sammly/core/widgets/custom_appbar.dart';
import 'package:sammly/features/generate/presentation/views/widgets/custom_stepper.dart';
import 'package:sammly/features/generate/presentation/views/widgets/step_1_upload.dart';
import 'package:sammly/features/generate/presentation/views/widgets/step_2_mask.dart';

class RemoveView extends StatefulWidget {
  const RemoveView({super.key});

  @override
  State<RemoveView> createState() => _RemoveViewState();
}

class _RemoveViewState extends State<RemoveView> {
  int _currentStep = 0;
  XFile? _selectedImage;

  void _nextStep() {
    if (_currentStep < 1 && _selectedImage != null) {
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
            : AppStrings.removeObject,
        onBack: _previousStep,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 80.w),
            child: CustomStepper(
              currentStep: _currentStep,
              stepTitles: const [AppStrings.upload, AppStrings.mask],
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
                : Step2Mask(
                    uploadedImage: _selectedImage!,
                    buttonText: AppStrings.remove,
                    onNext: (mask) {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.generateLoadingView,
                        arguments: {'showListView': false},
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
