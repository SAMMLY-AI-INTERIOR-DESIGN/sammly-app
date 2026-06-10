import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/constant/app_images.dart';
import 'package:sammly/core/constant/app_strings.dart';
import 'package:sammly/core/widgets/action_buttons_row.dart';
import 'package:sammly/features/generate/presentation/views/widgets/generate_results_app_bar.dart';
import 'package:sammly/features/generate/presentation/views/widgets/result_image_widget.dart';

class GenerateResultView extends StatefulWidget {
  final bool showListView;

  const GenerateResultView({super.key, this.showListView = false});

  @override
  State<GenerateResultView> createState() => _GenerateResultViewState();
}

class _GenerateResultViewState extends State<GenerateResultView> {
  final List<String> _images = [
    AppImages.roomLivingBohoTraditional,
    AppImages.styleRustic,
    AppImages.styleCoastal,
    AppImages.styleMidCentury,
  ];

  late String _selectedImage;

  @override
  void initState() {
    super.initState();
    _selectedImage = _images[0];
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
              ResultImageWidget(imagePath: _selectedImage),
              SizedBox(height: 16.h),
              if (widget.showListView) ...[
                SizedBox(
                  height: 100.h,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _images.length,
                    separatorBuilder: (context, index) => SizedBox(width: 10.w),
                    itemBuilder: (context, index) {
                      final image = _images[index];
                      final isSelected = _selectedImage == image;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedImage = image;
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
              ActionButtonsRow(
                onCustomize: () {},
                onShare: () {},
                onDownload: () {},
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}
