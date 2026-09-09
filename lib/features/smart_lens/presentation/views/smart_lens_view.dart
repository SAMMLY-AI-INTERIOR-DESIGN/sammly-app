import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/constant/app_images.dart';
import 'package:sammly/core/functions.dart';
import 'package:sammly/core/networking/cloudinary_service.dart';
import 'package:sammly/core/widgets/custom_appbar.dart';
import 'package:sammly/features/generate/presentation/views/widgets/step_1_upload.dart';
import 'package:sammly/features/smart_lens/cubit/search_cubit.dart';
import 'package:sammly/features/smart_lens/data/repo/search_repo.dart';
import 'package:sammly/features/smart_lens/presentation/widgets/smart_lens_bottom_sheet.dart';
import 'package:sammly/generated/l10n.dart';

class SmartLensView extends StatefulWidget {
  const SmartLensView({super.key});

  @override
  State<SmartLensView> createState() => _SmartLensViewState();
}

class _SmartLensViewState extends State<SmartLensView> {
  XFile? _selectedImage;
  bool _isLoading = false;
  late final SearchCubit _searchCubit;

  @override
  void initState() {
    super.initState();
    _searchCubit = SearchCubit(SearchRepo());
  }

  @override
  void dispose() {
    _searchCubit.close();
    super.dispose();
  }

  Future<void> _scanImage() async {
    if (_selectedImage == null) {
      showCustomSnackBar(
        context: context,
        message: S.of(context).pleaseUploadImage,
        isError: true,
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Step 1: Upload selected image to Cloudinary
      final cloudinaryUrl = await CloudinaryService.uploadImage(
        File(_selectedImage!.path),
      );

      if (!mounted) return;

      if (cloudinaryUrl == null || cloudinaryUrl.isEmpty) {
        setState(() => _isLoading = false);
        showCustomSnackBar(
          context: context,
          message: 'Failed to upload image. Please try again.',
          isError: true,
        );
        return;
      }

      // Step 2: Call POST /api/sourcing/search with the Cloudinary URL
      _searchCubit.searchByImage(cloudinaryUrl);

      setState(() {
        _isLoading = false;
      });

      // Step 3: Show results bottom sheet
      if (!mounted) return;
      showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        enableDrag: true,
        isScrollControlled: true,
        builder: (ctx) {
          return BlocProvider.value(
            value: _searchCubit,
            child: SmartLensBottomSheet(imageUrl: cloudinaryUrl),
          );
        },
      );
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
      showCustomSnackBar(
        context: context,
        message: 'Error analyzing image: $e',
        isError: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CustomAppbar(
        title: S.of(context).smartSammlyLens,
        onBack: () => Navigator.pop(context),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor),
            )
          : Column(
              children: [
                Expanded(
                  child: Step1Upload(
                    title: S.of(context).smartSammlyLens,
                    subtitle: S.of(context).uploadRoomForSmartLens,
                    titleIcon: AppImages.smartLensIcon,
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
                    onNext: _scanImage,
                  ),
                ),
              ],
            ),
    );
  }
}
