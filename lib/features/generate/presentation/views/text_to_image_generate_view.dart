import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/functions.dart';
import 'package:sammly/core/routing/routes.dart';
import 'package:sammly/core/widgets/custom_appbar.dart';
import 'package:sammly/features/generate/presentation/views/widgets/custom_stepper.dart';
import 'package:sammly/features/generate/presentation/views/widgets/logo_widget.dart';
import 'package:sammly/features/generate/presentation/views/widgets/text_to_image_step_1_room.dart';
import 'package:sammly/features/generate/presentation/views/widgets/text_to_image_step_2_style.dart';
import 'package:sammly/features/generate/presentation/views/widgets/text_to_image_step_3_describe.dart';
import 'package:sammly/generated/l10n.dart';

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
    FocusScope.of(context).unfocus();
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
    FocusScope.of(context).unfocus();
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

  Future<void> _generateDesign() async {
    final prompt = _promptController.text;
    if (prompt.isEmpty) {
      showCustomSnackBar(
        context: context,
        message: S.of(context).pleaseDescribeYourDreamRoom,
        isError: true,
      );
      return;
    }

    final RegExp bedsRegexEn = RegExp(r'(?:2|two|3|three|4|four)\s*beds?\b|\bbeds\b', caseSensitive: false);
    final RegExp bedsRegexAr = RegExp(r'(?:2|٢|3|٣|4|٤)\s*(?:سرير|سراير|سريران|[أا]سر[ةه])|سريرين|سريران|(?:ثلاث|ثلاثة|اربع|أربع|اربعة|أربعة)\s*(?:سرير|سراير|[أا]سر[ةه])|\b(?:[أا]سر[ةه]|سراير)\b');
    
    bool isEnMatch = bedsRegexEn.hasMatch(prompt);
    bool isArMatch = bedsRegexAr.hasMatch(prompt);

    if (isEnMatch || isArMatch) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(color: AppColors.primaryColor),
        ),
      );

      await Future.delayed(const Duration(seconds: 2));

      if (!mounted) return;
      Navigator.pop(context);

      String message = isArMatch 
          ? "لا ندعم هذه الحالة، ربما في المستقبل" 
          : "We Don't handle this case, maybe in the future";

      showCustomSnackBar(
        context: context,
        message: message,
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
        return S.of(context).selectRoom;
      case 1:
        return S.of(context).selectStyle;
      case 2:
        return ""; // The logo will be shown in the body instead of app bar title
      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableHeight =
        MediaQuery.of(context).size.height -
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
                  CustomAppbar(title: _getAppBarTitle(), onBack: _previousStep),

                  if (_currentStep == 2) ...[
                    LogoWidget(),
                    SizedBox(height: 10.h),
                  ],

                  CustomStepper(
                    currentStep: _currentStep,
                    stepTitles: [
                      S.of(context).type,
                      S.of(context).style,
                      S.of(context).describe,
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
