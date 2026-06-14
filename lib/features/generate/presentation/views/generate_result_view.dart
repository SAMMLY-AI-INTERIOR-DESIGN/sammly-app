import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/constant/app_images.dart';
import 'package:sammly/core/constant/app_strings.dart';
import 'package:sammly/core/widgets/generate_action_buttons_row.dart';
import 'package:sammly/features/generate/presentation/views/widgets/generate_results_app_bar.dart';
import 'package:sammly/features/generate/presentation/views/widgets/result_image_widget.dart';
import 'package:sammly/features/smart_lens/cubit/search_cubit.dart';
import 'package:sammly/features/smart_lens/data/repo/search_repo.dart';
import 'package:sammly/features/smart_lens/presentation/widgets/smart_lens_bottom_sheet.dart';

class GenerateResultView extends StatefulWidget {
  final bool showListView;
  final String? networkImageUrl;
  final String? designId;

  const GenerateResultView({
    super.key,
    this.showListView = false,
    this.networkImageUrl,
    this.designId,
  });

  @override
  State<GenerateResultView> createState() => _GenerateResultViewState();
}

class _GenerateResultViewState extends State<GenerateResultView> {
  final List<String> _fallbackImages = [
    AppImages.roomLivingBohoTraditional,
    AppImages.styleRustic,
    AppImages.styleCoastal,
    AppImages.styleMidCentury,
  ];

  late final SearchCubit _searchCubit;

  void _openSmartLens(BuildContext context) {
    if (widget.designId == null || widget.designId!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Design ID not available. Please try generating again."),
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
          child: SmartLensBottomSheet(designId: widget.designId!),
        );
      },
    );
  }

  late String _selectedImage;
  late bool _isNetworkImage;

  @override
  void initState() {
    super.initState();
    _searchCubit = SearchCubit(SearchRepo());
    if (widget.networkImageUrl != null && widget.networkImageUrl!.isNotEmpty) {
      _selectedImage = widget.networkImageUrl!;
      _isNetworkImage = true;
    } else {
      _selectedImage = _fallbackImages[0];
      _isNetworkImage = false;
    }
  }

  @override
  void dispose() {
    _searchCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: GenerateResultsAppBar(
        title: widget.showListView
            ? AppStrings.yourGeneratedDesign
            : AppStrings.modernLivingRoom,
        subtitle: AppStrings.generatedBySammly,
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
              ),
              SizedBox(height: 16.h),
              if (widget.showListView && !_isNetworkImage) ...[
                SizedBox(
                  height: 100.h,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _fallbackImages.length,
                    separatorBuilder: (context, index) => SizedBox(width: 10.w),
                    itemBuilder: (context, index) {
                      final image = _fallbackImages[index];
                      final isSelected = _selectedImage == image;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedImage = image;
                            _isNetworkImage = false;
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
                                color: Colors.black.withValues(alpha: 0.05),
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
                                image: AssetImage(image),
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
              GenerateActionButtonsRow(
                imageUrl: _isNetworkImage ? _selectedImage : null,
                onEdit: () {},
                onShare: () {},
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}
