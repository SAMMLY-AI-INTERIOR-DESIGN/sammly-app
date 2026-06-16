import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/constant/app_images.dart';
import 'package:sammly/core/routing/routes.dart';
import 'package:sammly/core/widgets/custom_appbar.dart';
import 'package:sammly/features/generate/presentation/views/widgets/custom_stepper.dart';
import 'package:sammly/core/functions.dart';
import 'package:sammly/features/generate/presentation/views/widgets/step_1_upload.dart';
import 'package:sammly/features/generate/presentation/views/widgets/text_to_image_step_2_style.dart';
import 'package:sammly/generated/l10n.dart';

class RestyleView extends StatefulWidget {
  final String? initialImageUrl;
  const RestyleView({super.key, this.initialImageUrl});

  @override
  State<RestyleView> createState() => _RestyleViewState();
}

class _RestyleViewState extends State<RestyleView> {
  int _currentStep = 0;
  String? _selectedStyle;
  XFile? _selectedImage;
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
        '${tempDir.path}/restyle_initial_image_${DateTime.now().millisecondsSinceEpoch}.jpg',
      );
      await file.writeAsBytes(response.data!);

      if (!mounted) return;

      setState(() {
        _selectedImage = XFile(file.path);
        _currentStep = 1; // Move directly to style step
        _isDownloadingImage = false;
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

  void _nextStep() {
    if (_currentStep == 0 && _selectedImage == null) {
      showCustomSnackBar(
        context: context,
        message: 'Please upload a reference image.',
        isError: true,
      );
      return;
    }
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
            ? S.of(context).uploadRoom
            : S.of(context).selectStyle,
        onBack: _previousStep,
      ),
      body: _isDownloadingImage
          ? const Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 80.w),
                  child: CustomStepper(
                    currentStep: _currentStep,
                    stepTitles: [S.of(context).upload, S.of(context).style],
                  ),
                ),
                Expanded(
                  child: _currentStep == 0
                      ? Step1Upload(
                          title: S.of(context).uploadReferenceImage,
                          subtitle: S.of(context).addReferenceImageOnly,
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
                              arguments: {
                                'isRestyle': true,
                                'style': _selectedStyle ?? '',
                                'imageUrl': _selectedImage?.path,
                                'showListView': false,
                              },
                            );
                          },
                          buttonText: S.of(context).restyleYourSpace,
                          buttonPrefixIcon: AppImages.startGenerateIcon,
                        ),
                ),
              ],
            ),
    );
  }
}
