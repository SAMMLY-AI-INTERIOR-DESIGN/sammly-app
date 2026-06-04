import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/features/generate/presentation/views/widgets/custom_stepper.dart';
import 'package:sammly/features/generate/presentation/views/widgets/step_1_upload.dart';
import 'package:sammly/features/generate/presentation/views/widgets/step_2_mask.dart';
import 'package:sammly/features/generate/presentation/views/widgets/step_3_describe.dart';

class ImageGenerationStepperView extends StatefulWidget {
  const ImageGenerationStepperView({super.key});

  @override
  State<ImageGenerationStepperView> createState() =>
      _ImageGenerationStepperViewState();
}

class _ImageGenerationStepperViewState
    extends State<ImageGenerationStepperView> {
  int _currentStep = 0;
  final PageController _pageController = PageController();

  XFile? _uploadedImage;
  XFile? _maskImage;
  final TextEditingController _promptController = TextEditingController();

  @override
  void dispose() {
    _pageController.dispose();
    _promptController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep < 2) {
      setState(() {
        _currentStep++;
      });
      _pageController.animateToPage(
        _currentStep,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
      _pageController.animateToPage(
        _currentStep,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pop(context);
    }
  }

  void _handleImageSelected(XFile image) {
    setState(() {
      _uploadedImage = image;
    });
  }

  void _handleMaskExtracted(XFile mask) {
    setState(() {
      _maskImage = mask;
    });
    _nextStep();
  }

  void _generateDesign() {
    final prompt = _promptController.text;
    if (prompt.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter a description."),
          backgroundColor: AppColors.redColor,
        ),
      );
      return;
    }

    // TODO: Send _uploadedImage, _maskImage, and prompt to the backend API.
    debugPrint("Image: ${_uploadedImage?.path}");
    debugPrint("Mask: ${_maskImage?.path}");
    debugPrint("Prompt: $prompt");

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Generating design..."),
        backgroundColor: AppColors.secondaryColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.blackColor,
          ),
          onPressed: _previousStep,
        ),
        title: Text(
          'Upload Image',
          style: TextStyle(
            color: AppColors.blackColor,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          CustomStepper(currentStep: _currentStep),
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Step1Upload(
                  initialImage: _uploadedImage,
                  onImageSelected: _handleImageSelected,
                  onImageRemoved: () {
                    setState(() {
                      _uploadedImage = null;
                      _maskImage = null;
                    });
                  },
                  onNext: _nextStep,
                ),
                if (_uploadedImage != null)
                  Step2Mask(
                    uploadedImage: _uploadedImage!,
                    onNext: _handleMaskExtracted,
                  )
                else
                  const Center(child: Text("Please upload an image first")),
                Step3Describe(
                  promptController: _promptController,
                  onGenerate: _generateDesign,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
