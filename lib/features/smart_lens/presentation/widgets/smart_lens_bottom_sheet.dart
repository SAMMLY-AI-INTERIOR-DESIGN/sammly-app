import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/theme/text_styles.dart';
import 'package:sammly/features/search/presentation/widgets/similar_item_card.dart';
import 'package:sammly/features/smart_lens/cubit/search_cubit.dart';
import 'package:sammly/features/smart_lens/cubit/search_state.dart';
import 'package:sammly/features/smart_lens/data/models/search_response.dart';

class SmartLensBottomSheet extends StatefulWidget {
  final String designId;

  const SmartLensBottomSheet({super.key, required this.designId});

  @override
  State<SmartLensBottomSheet> createState() => _SmartLensBottomSheetState();
}

class _SmartLensBottomSheetState extends State<SmartLensBottomSheet> {
  int _selectedCategoryIndex = 0;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<SearchCubit>();
    if (cubit.state is! SearchLoaded && cubit.state is! SearchLoading) {
      cubit.searchDesign(widget.designId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.45,
      minChildSize: 0.25,
      maxChildSize: 0.85,
      snap: true,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.r),
              topRight: Radius.circular(24.r),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 10,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: Column(
            children: [
              // الـ Notch أو خط السحب العلوي
              SizedBox(height: 12.h),
              Container(
                width: 48.w,
                height: 5.h,
                decoration: BoxDecoration(
                  color: const Color(0xFF2E2E2E),
                  borderRadius: BorderRadius.circular(2.5.r),
                ),
              ),
              SizedBox(height: 24.h),

              // النصوص الرأسية الثابتة
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Similar items',
                        style: TextStyle(
                          color: const Color(0xFF2E2E2E),
                          fontSize: 22.sp,
                          fontFamily: 'Manrope',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      BlocBuilder<SearchCubit, SearchState>(
                        builder: (context, state) {
                          if (state is SearchLoaded && state.response.data.any((r) => r.productMatches.isNotEmpty)) {
                            return Padding(
                              padding: EdgeInsets.only(top: 6.h),
                              child: Text(
                                'We found similar items for your design.',
                                style: TextStyle(
                                  color: const Color(0xFF5B5B5B),
                                  fontSize: 14.sp,
                                  fontFamily: 'Manrope',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.h),

              // BlocBuilder for state management
              Expanded(
                child: BlocBuilder<SearchCubit, SearchState>(
                  builder: (context, state) {
                    if (state is SearchLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        ),
                      );
                    }

                    if (state is SearchError) {
                      return _buildErrorView(state.message);
                    }

                    if (state is SearchLoaded) {
                      final results = state.response.data;

                      if (results.isEmpty) {
                        return _buildEmptyView();
                      }

                      return _buildResultsView(results, scrollController);
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// Option C layout: FilterChips on top + GridView below
  Widget _buildResultsView(
    List<SourcingResult> results,
    ScrollController scrollController,
  ) {
    // Filter out results that have no products
    final nonEmptyResults = results.where((r) => r.productMatches.isNotEmpty).toList();

    if (nonEmptyResults.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Text(
            'No products found for this design.',
            style: AppTextStyles.body14Regular.copyWith(
              color: const Color(0xFF5B5B5B),
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return ListView.builder(
      controller: scrollController,
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
      itemCount: nonEmptyResults.length,
      itemBuilder: (context, index) {
        final result = nonEmptyResults[index];
        // Use label if available, otherwise fallback to detected category
        final title = result.label.isNotEmpty ? result.label : result.detectedCategory;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category Name
            Text(
              title,
              style: AppTextStyles.body16Medium.copyWith(
                color: const Color(0xFF2E2E2E),
                fontWeight: FontWeight.w700,
                fontSize: 18.sp,
              ),
            ),
            SizedBox(height: 8.h),
            const Divider(color: Color(0xFFC0C0C0), thickness: 1),
            SizedBox(height: 16.h),
            
            // Grid of products
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: result.productMatches.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.w,
                mainAxisSpacing: 16.h,
                childAspectRatio: 0.76,
              ),
              itemBuilder: (context, productIndex) {
                final product = result.productMatches[productIndex];
                return SimilarItemCard(
                  item: SimilarItemModel(
                    title: product.title,
                    subtitle: product.price,
                    imageUrl: product.thumbnail,
                    productUrl: product.url,
                  ),
                );
              },
            ),
            SizedBox(height: 32.h), // Spacing between categories
          ],
        );
      },
    );
  }

  Widget _buildErrorView(String message) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, size: 48.sp, color: AppColors.greyColor),
            SizedBox(height: 16.h),
            Text(
              message,
              style: AppTextStyles.body14Regular.copyWith(
                color: const Color(0xFF5B5B5B),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.h),
            ElevatedButton(
              onPressed: () {
                context.read<SearchCubit>().searchDesign(widget.designId);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              ),
              child: Text(
                'Retry',
                style: AppTextStyles.body16Medium.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyView() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.search_off, size: 48.sp, color: AppColors.greyColor),
            SizedBox(height: 16.h),
            Text(
              'No similar items found for this design.',
              style: AppTextStyles.body14Regular.copyWith(
                color: const Color(0xFF5B5B5B),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
