import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/constant/app_images.dart';
import 'package:sammly/core/routing/routes.dart';
import 'package:sammly/core/utils/image_download_helper.dart';
import 'package:sammly/core/widgets/generate_action_buttons_row.dart';
import 'package:sammly/core/widgets/edit_download_action_buttons_row.dart';
import 'package:sammly/features/generate/presentation/views/widgets/generate_results_app_bar.dart';
import 'package:sammly/features/generate/presentation/views/widgets/result_image_widget.dart';
import 'package:sammly/features/generate/data/model/generate_design_response_model.dart';
import 'package:sammly/features/smart_lens/cubit/search_cubit.dart';
import 'package:sammly/features/smart_lens/data/repo/search_repo.dart';
import 'package:sammly/features/smart_lens/presentation/widgets/smart_lens_bottom_sheet.dart';
import 'package:sammly/features/Explore/cubit/design_details_cubit.dart';
import 'package:sammly/features/Explore/cubit/design_details_states.dart';
import 'package:sammly/generated/l10n.dart';

class GenerateResultView extends StatefulWidget {
  final bool showListView;
  final String? networkImageUrl;
  final String? designId;
  final List<dynamic>? designs;
  final String? originalImageUrl;
  final bool isFromStepper;

  const GenerateResultView({
    super.key,
    this.showListView = false,
    this.networkImageUrl,
    this.designId,
    this.designs,
    this.originalImageUrl,
    this.isFromStepper = false,
  });

  @override
  State<GenerateResultView> createState() => _GenerateResultViewState();
}

class _GenerateResultViewState extends State<GenerateResultView> {
  final List<String> _fallbackImages = [
    AppImages.styleTraditional,
    AppImages.styleRustic,
    AppImages.styleCoastal,
    AppImages.styleMidCentury,
    AppImages.styleBoho,
  ];

  late final SearchCubit _searchCubit;

  void _openSmartLens(BuildContext context) {
    if (_currentDesignId == null || _currentDesignId!.isEmpty) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text(
              "Design ID not available. Please try generating again.",
            ),
            backgroundColor: Colors.red,
          ),
        );
      return;
    }

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      enableDrag: true,
      isScrollControlled: true,
      builder: (context) {
        return BlocProvider.value(
          value: _searchCubit,
          child: SmartLensBottomSheet(designId: _currentDesignId!),
        );
      },
    );
  }

  late String _selectedImage;
  late bool _isNetworkImage;
  late int _selectedIndex;
  String? _currentDesignId;
  List<String> _listImages = [];

  @override
  void initState() {
    super.initState();
    _searchCubit = SearchCubit(SearchRepo());
    _currentDesignId = widget.designId;

    if (widget.designs != null && widget.designs!.isNotEmpty) {
      _listImages = widget.designs!
          .map((d) => (d as GenerateDesignResponseModel).imageUrl)
          .toList();
    } else {
      _listImages = _fallbackImages;
    }

    _selectedIndex = 0;

    if (widget.networkImageUrl != null && widget.networkImageUrl!.isNotEmpty) {
      _selectedImage = widget.networkImageUrl!;
      _isNetworkImage = true;
      // If networkImageUrl matches one in the list, set index
      final index = _listImages.indexOf(widget.networkImageUrl!);
      if (index != -1) _selectedIndex = index;
    } else {
      _selectedImage = _listImages[0];
      _isNetworkImage = widget.designs != null && widget.designs!.isNotEmpty;
    }
  }

  @override
  void dispose() {
    _searchCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DesignDetailsCubit, DesignDetailsState>(
      listener: (context, state) {
        if (state is DesignShareSuccess) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColors.primaryColor,
                behavior: SnackBarBehavior.floating,
              ),
            );
        } else if (state is DesignActionError) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
              ),
            );
        }
      },
      child: BlocBuilder<DesignDetailsCubit, DesignDetailsState>(
        builder: (context, designState) {
          final isShared = widget.designId != null
              ? context.read<DesignDetailsCubit>().isSharedLocal(
                  widget.designId!,
                )
              : false;
          return Scaffold(
            backgroundColor: AppColors.whiteColor,
            appBar: GenerateResultsAppBar(
              title: widget.showListView
                  ? S.of(context).yourGeneratedDesign
                  : S.of(context).modernLivingRoom,
              subtitle: S.of(context).generatedBySammly,
              onBack: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.layoutView,
                  (route) => false,
                );
              },
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                child: Column(
                  children: [
                    ResultImageWidget(
                      imagePath: _selectedImage,
                      isNetworkImage: _isNetworkImage,
                      onSmartLensTap: () => _openSmartLens(context),
                      originalImagePath: widget.originalImageUrl,
                    ),
                    SizedBox(height: 16.h),
                    if (widget.showListView) ...[
                      SizedBox(
                        height: 100.h,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: _listImages.length,
                          separatorBuilder: (context, index) =>
                              SizedBox(width: 10.w),
                          itemBuilder: (context, index) {
                            final image = _listImages[index];
                            final isSelected = _selectedIndex == index;
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedIndex = index;
                                  _selectedImage = image;
                                  _isNetworkImage =
                                      widget.designs != null &&
                                      widget.designs!.isNotEmpty;
                                  if (widget.designs != null &&
                                      widget.designs!.isNotEmpty) {
                                    _currentDesignId =
                                        (widget.designs![index]
                                                as GenerateDesignResponseModel)
                                            .id;
                                  }
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  gradient: isSelected
                                      ? AppColors.primaryGradient3
                                      : null,
                                  color: isSelected ? null : Colors.transparent,
                                  borderRadius: BorderRadius.circular(10.r),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(
                                        alpha: 0.05,
                                      ),
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Container(
                                  width: 100.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    image: DecorationImage(
                                      image:
                                          (widget.designs != null &&
                                              widget.designs!.isNotEmpty)
                                          ? NetworkImage(image) as ImageProvider
                                          : AssetImage(image),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                    widget.showListView
                        ? SizedBox(height: 17.h)
                        : SizedBox(height: 56.h),
                    widget.isFromStepper
                        ? EditDownloadActionButtonsRow(
                            imageUrl: _isNetworkImage ? _selectedImage : null,
                            onEdit: () {
                              Navigator.pushNamed(
                                context,
                                AppRoutes.imageGenerationStepperView,
                                arguments: {
                                  'initialImageUrl': _selectedImage,
                                  'isEditMode': true,
                                },
                              );
                            },
                            onDownload: () {
                              if (_isNetworkImage) {
                                ImageDownloadHelper.downloadNetworkImage(
                                  context,
                                  _selectedImage,
                                );
                              }
                            },
                          )
                        : GenerateActionButtonsRow(
                            imageUrl: _isNetworkImage ? _selectedImage : null,
                            isShared: isShared,
                            onEdit: () {
                              Navigator.pushNamed(
                                context,
                                AppRoutes.imageGenerationStepperView,
                                arguments: {
                                  'initialImageUrl': _selectedImage,
                                  'isEditMode': true,
                                },
                              );
                            },
                            onShare: () {
                              if (widget.designId != null &&
                                  widget.designId!.isNotEmpty) {
                                context.read<DesignDetailsCubit>().shareDesign(
                                  widget.designId!,
                                );
                              } else {
                                ScaffoldMessenger.of(context)
                                  ..hideCurrentSnackBar()
                                  ..showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Design ID not available. Cannot share.',
                                      ),
                                      backgroundColor: Colors.red,
                                      behavior: SnackBarBehavior.floating,
                                    ),
                                  );
                              }
                            },
                          ),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
