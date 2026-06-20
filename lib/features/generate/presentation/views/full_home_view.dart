import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/constant/app_images.dart';
import 'package:sammly/core/functions.dart';
import 'package:sammly/core/routing/routes.dart';
import 'package:sammly/core/theme/text_styles.dart';
import 'package:sammly/core/widgets/custom_appbar.dart';
import 'package:sammly/core/widgets/custombutton.dart';
import 'package:sammly/features/generate/presentation/views/widgets/custom_stepper.dart';
import 'package:sammly/features/generate/presentation/views/widgets/logo_widget.dart';
import 'package:sammly/features/generate/presentation/views/widgets/room_filter_widget.dart';
import 'package:sammly/features/generate/presentation/views/widgets/step_1_upload.dart';
import 'package:sammly/features/generate/presentation/views/widgets/text_to_image_step_2_style.dart';
import 'package:sammly/generated/l10n.dart';

class FullHomeView extends StatefulWidget {
  const FullHomeView({super.key});

  @override
  State<FullHomeView> createState() => _FullHomeViewState();
}

class _FullHomeViewState extends State<FullHomeView> {
  int _currentStep = 0;
  XFile? _selectedImage;
  String? _selectedStyle;

  final List<String> _allRooms = [
    S.current.bedroom,
    S.current.diningRoom,
    S.current.kitchen,
    S.current.bathroom,
    S.current.livingRoom,
  ];
  late List<String> _selectedRooms;

  @override
  void initState() {
    super.initState();
    _selectedRooms = List.from(_allRooms);
  }

  void _nextStep() {
    if (_currentStep < 2) {
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

  void _toggleRoom(String room) {
    setState(() {
      if (_selectedRooms.contains(room)) {
        _selectedRooms.remove(room);
      } else {
        _selectedRooms.add(room);
      }
    });
  }

  void _toggleAll() {
    setState(() {
      if (_selectedRooms.length == _allRooms.length) {
        _selectedRooms.clear();
      } else {
        _selectedRooms = List.from(_allRooms);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppbar(title: '', onBack: _previousStep, showLeading: true),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const LogoWidget(),
          SizedBox(height: 16.h),
          CustomStepper(
            currentStep: _currentStep,
            stepTitles: [
              S.of(context).upload,
              S.of(context).style,
              S.of(context).select,
            ],
          ),
          Expanded(
            child: _currentStep == 0
                ? _buildUploadStep()
                : _currentStep == 1
                ? _buildStyleStep()
                : _buildSelectStep(),
          ),
        ],
      ),
    );
  }

  Widget _buildUploadStep() {
    return Step1Upload(
      title: S.of(context).uploadReferenceImage,
      subtitle: S.of(context).addReferenceImageOptional,
      titleIcon: AppImages.aiPoweredIcon,
      isButtonInsideCard: true,
      initialImage: _selectedImage,
      isImageOptional: true,
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
    );
  }

  Widget _buildStyleStep() {
    return TextToImageStep2Style(
      selectedStyle: _selectedStyle,
      onStyleSelected: (style) {
        setState(() {
          _selectedStyle = style;
        });
      },
      onNext: _nextStep,
    );
  }

  Widget _buildSelectStep() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 32.h),
          Text(
            S.of(context).buildYourRoom,
            style: AppTextStyles.title18SemiBold.copyWith(
              color: AppColors.blackColor,
            ),
          ),
          SizedBox(height: 24.h),
          RoomFilterWidget(
            allRooms: _allRooms,
            selectedRooms: _selectedRooms,
            onRoomToggled: _toggleRoom,
            onAllToggled: _toggleAll,
          ),
          const Spacer(),
          CustomButton(
            text: S.of(context).generateDesign,
            prefixIcon: AppImages.startGenerateIcon,
            onPressed: () {
              if (_selectedRooms.isEmpty) {
                showCustomSnackBar(
                  context: context,
                  message: S.of(context).pleaseSelectAtLeastOneRoom,
                  isError: true,
                );
              } else {
                Navigator.pushNamed(
                  context,
                  AppRoutes.generateLoadingView,
                  arguments: {
                    'showListView': true,
                    'isFullHome': true,
                    'style': _selectedStyle ?? '',
                    'roomTypes': _selectedRooms,
                    'style_image_url': _selectedImage?.path,
                  },
                );
              }
            },
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}
