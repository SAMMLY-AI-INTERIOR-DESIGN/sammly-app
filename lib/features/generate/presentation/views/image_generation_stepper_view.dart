import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/routing/routes.dart';
import 'package:sammly/features/generate/presentation/views/widgets/custom_stepper.dart';
import 'package:sammly/features/generate/presentation/views/widgets/step_1_upload.dart';
import 'package:sammly/features/generate/presentation/views/widgets/step_2_mask.dart';
import 'package:sammly/features/generate/presentation/views/widgets/step_3_describe.dart';
import 'package:sammly/generated/l10n.dart';

class ImageGenerationStepperView extends StatefulWidget {
  final String? initialImageUrl;
  final bool isEditMode;

  const ImageGenerationStepperView({
    super.key,
    this.initialImageUrl,
    this.isEditMode = false,
  });

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
  bool _isDownloadingImage = false;

  @override
  void initState() {
    super.initState();
    if (widget.initialImageUrl != null && widget.initialImageUrl!.isNotEmpty) {
      _downloadInitialImage(widget.initialImageUrl!);
    }
  }

  Future<void> _downloadInitialImage(String url) async {
    setState(() {
      _isDownloadingImage = true;
    });
    try {
      final dio = Dio();
      final response = await dio.get<List<int>>(
        url,
        options: Options(responseType: ResponseType.bytes),
      );

      final tempDir = await getTemporaryDirectory();
      final file = File(
        '${tempDir.path}/initial_image_${DateTime.now().millisecondsSinceEpoch}.jpg',
      );
      await file.writeAsBytes(response.data!);

      if (!mounted) return;

      setState(() {
        _uploadedImage = XFile(file.path);
        _currentStep = 1; // Move directly to mask step
        _isDownloadingImage = false;
      });

      // Delay jumping the page controller to allow layout to build
      Future.delayed(const Duration(milliseconds: 100), () {
        if (mounted) {
          _pageController.jumpToPage(1);
        }
      });
    } catch (e) {
      debugPrint("Failed to download image: $e");
      if (mounted) {
        setState(() {
          _isDownloadingImage = false;
        });
      }
    }
  }

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

  Future<void> _generateDesign() async {
    final prompt = _promptController.text;
    if (prompt.isEmpty) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(S.of(context).pleaseEnterDescription),
            backgroundColor: AppColors.redColor,
          ),
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

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: AppColors.primaryColor,
          ),
        );
      return;
    }

    // TODO: Send _uploadedImage, _maskImage, and prompt to the backend API.
    debugPrint("Image: ${_uploadedImage?.path}");
    debugPrint("Mask: ${_maskImage?.path}");
    debugPrint("Prompt: $prompt");

    Navigator.pushNamed(
      context,
      AppRoutes.generateLoadingView,
      arguments: {
        'showListView': false,
        'isMask': true,
        'operationMode': widget.isEditMode ? 'edit' : 'replace',
        'imageUrl': _uploadedImage?.path,
        'maskUrl': _maskImage?.path,
        'prompt': prompt,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: _currentStep == 2,
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
          widget.isEditMode 
              ? S.of(context).editImage 
              : S.of(context).replaceObject,
          style: TextStyle(
            color: AppColors.blackColor,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: _isDownloadingImage
          ? const Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor),
            )
          : Column(
              children: [
                CustomStepper(
                  currentStep: _currentStep,
                  stepTitles: [
                    S.of(context).upload,
                    S.of(context).mask,
                    S.of(context).describe,
                  ],
                ),
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      Step1Upload(
                        title: S.of(context).uploadYourImage,
                        subtitle: S.of(context).addYourImage,
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
                        Center(
                          child: Text(S.of(context).pleaseUploadImageFirst),
                        ),
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
