import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/constant/app_strings.dart';
import 'package:sammly/core/functions.dart';
import 'package:sammly/core/routing/routes.dart';
import 'package:sammly/core/widgets/custom_appbar.dart';
import 'package:sammly/features/generate/presentation/views/widgets/custom_stepper.dart';
import 'package:sammly/features/generate/presentation/views/widgets/logo_widget.dart';
import 'package:sammly/features/generate/presentation/views/widgets/text_to_image_step_1_room.dart';
import 'package:sammly/features/generate/presentation/views/widgets/text_to_image_step_2_style.dart';
import 'package:sammly/features/generate/presentation/views/widgets/text_to_image_step_3_describe.dart';

class TextToImageGenerateView extends StatefulWidget {
  const TextToImageGenerateView({super.key});

  @override
  State<TextToImageGenerateView> createState() =>
      _TextToImageGenerateViewState();
}

class _TextToImageGenerateViewState extends State<TextToImageGenerateView> {
  int _currentStep = 0;
  final PageController _pageController = PageController();

  String? _selectedRoom;
  String? _selectedStyle;
  final TextEditingController _promptController = TextEditingController();
  XFile? _referenceImage;

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

  void _generateDesign() {
    final prompt = _promptController.text;
    if (prompt.isEmpty) {
      showCustomSnackBar(
        context: context,
        message: AppStrings.pleaseDescribeYourDreamRoom,
        isError: true,
      );
      return;
    }

    Navigator.pushNamed(
      context,
      AppRoutes.generateLoadingView,
      arguments: {
        'room': _selectedRoom ?? '',
        'style': _selectedStyle ?? '',
        'prompt': prompt,
        'imageUrl': _referenceImage?.path,
      },
    );
  }

  String _getAppBarTitle() {
    switch (_currentStep) {
      case 0:
        return AppStrings.selectRoom;
      case 1:
        return AppStrings.selectStyle;
      case 2:
        return ""; // The logo will be shown in the body instead of app bar title
      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        
        body: SafeArea(
          child: SingleChildScrollView(
            child: SizedBox(
              height: availableHeight,
              child: Column(
                children: [
                  CustomAppbar(
                    title: _getAppBarTitle(), 
                    onBack: _previousStep,
                  ),
                  
                  if (_currentStep == 2) ...[
                    LogoWidget(),
                    SizedBox(height: 10.h),
                  ],
                  
                  CustomStepper(
                    currentStep: _currentStep,
                    stepTitles: const [
                      AppStrings.type,
                      AppStrings.style,
                      AppStrings.describe,
                    ],
                  ),
                  
                  Expanded(
                    child: PageView(
                      controller: _pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        TextToImageStep1Room(
                          selectedRoom: _selectedRoom,
                          onRoomSelected: (room) {
                            setState(() {
                              _selectedRoom = room;
                            });
                          },
                          onNext: _nextStep,
                        ),
                        TextToImageStep2Style(
                          selectedStyle: _selectedStyle,
                          onStyleSelected: (style) {
                            setState(() {
                              _selectedStyle = style;
                            });
                          },
                          onNext: _nextStep,
                        ),
                        TextToImageStep3Describe(
                          promptController: _promptController,
                          referenceImage: _referenceImage,
                          onImageSelected: (image) {
                            setState(() {
                              _referenceImage = image;
                            });
                          },
                          onImageRemoved: () {
                            setState(() {
                              _referenceImage = null;
                            });
                          },
                          onGenerate: _generateDesign,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
