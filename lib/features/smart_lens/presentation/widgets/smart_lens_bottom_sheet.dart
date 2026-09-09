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
  final String imageUrl;

  const SmartLensBottomSheet({super.key, required this.imageUrl});

  @override
  State<SmartLensBottomSheet> createState() => _SmartLensBottomSheetState();
}

class _SmartLensBottomSheetState extends State<SmartLensBottomSheet> {
  @override
  void initState() {
    super.initState();
    final cubit = context.read<SearchCubit>();
    if (cubit.state is! SearchLoaded && cubit.state is! SearchLoading) {
      cubit.searchByImage(widget.imageUrl);
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
              // Drag handle
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

              // Header
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
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
                          if (state is SearchLoaded &&
                              state.response.matches.isNotEmpty) {
                            return Padding(
                              padding: EdgeInsetsDirectional.only(top: 6.h),
                              child: Text(
                                'We found ${state.response.totalResults} similar items for your image.',
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

              // Credits info
              BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) {
                  if (state is SearchLoaded) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Row(
                        children: [
                          Icon(Icons.toll, size: 16.sp, color: AppColors.primaryColor),
                          SizedBox(width: 6.w),
                          Text(
                            'Credits: ${state.response.remainingCredits} remaining',
                            style: TextStyle(
                              color: const Color(0xFF5B5B5B),
                              fontSize: 12.sp,
                              fontFamily: 'Manrope',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),

              SizedBox(height: 8.h),

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
                      final response = state.response;

                      if (!response.matchFound || response.matches.isEmpty) {
                        return _buildEmptyView(response);
                      }

                      return _buildResultsView(response.matches, scrollController);
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

  Widget _buildResultsView(
    List<SourcingMatch> matches,
    ScrollController scrollController,
  ) {
    return GridView.builder(
      controller: scrollController,
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
      itemCount: matches.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.w,
        mainAxisSpacing: 16.h,
        childAspectRatio: 0.76,
      ),
      itemBuilder: (context, index) {
        final match = matches[index];
        return SimilarItemCard(
          item: SimilarItemModel(
            title: match.title,
            subtitle: match.price,
            imageUrl: match.thumbnail,
            productUrl: match.url,
          ),
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
                context.read<SearchCubit>().searchByImage(widget.imageUrl);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              ),
              child: Text(
                'Try Again',
                style: AppTextStyles.body16Medium.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyView(SearchResponse response) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.search_off, size: 48.sp, color: AppColors.greyColor),
            SizedBox(height: 16.h),
            Text(
              response.message ?? 'No similar items found for this image.',
              style: AppTextStyles.body14Regular.copyWith(
                color: const Color(0xFF5B5B5B),
              ),
              textAlign: TextAlign.center,
            ),
            if (response.detectedCategories.isNotEmpty) ...[
              SizedBox(height: 12.h),
              Text(
                'Detected: ${response.detectedCategories.join(", ")}',
                style: TextStyle(
                  color: const Color(0xFF8B8B8B),
                  fontSize: 12.sp,
                  fontFamily: 'Manrope',
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
