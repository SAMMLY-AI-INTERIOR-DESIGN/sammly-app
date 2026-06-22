import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/constant/app_images.dart';
import 'package:sammly/core/theme/text_styles.dart';
import 'package:sammly/core/widgets/custom_appbar.dart';
import 'package:sammly/features/History/cubit/historycubit.dart';
import 'package:sammly/features/History/cubit/history_state.dart';
import 'package:sammly/features/History/presentation/widgets/customhistory.dart';
import 'package:sammly/features/History/presentation/views/historydetails.dart';
import 'package:sammly/features/layout/presentation/cubit/layout_cubit/layout_cubit.dart';
import 'package:sammly/generated/l10n.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<HistoryCubit>().fetchHistory();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      final cubit = context.read<HistoryCubit>();
      if (cubit.hasMore && cubit.state is! HistoryPaginationLoading) {
        cubit.loadMore();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CustomAppbar(
        title: S.of(context).history,
        onBack: () => context.read<LayoutCubit>().changeIndex(0),
      ),
      body: SafeArea(
        child: BlocBuilder<HistoryCubit, HistoryState>(
          builder: (context, state) {
            // Initial loading
            if (state is HistoryLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            // Error state
            if (state is HistoryError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(AppImages.noImage),
                    SizedBox(height: 16.h),
                    Text(
                      state.message,
                      style: AppTextStyles.body16Regular.copyWith(
                        color: AppColors.greyColor.withValues(alpha: 0.6),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16.h),
                    TextButton(
                      onPressed: () =>
                          context.read<HistoryCubit>().fetchHistory(),
                      child: Text(
                        S.of(context).retry,
                        style: AppTextStyles.body16Regular.copyWith(
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }

            // Loaded state (or loading more pages)
            if (state is HistoryLoaded || state is HistoryPaginationLoading) {
              final displayDesigns = state is HistoryLoaded
                  ? state.designs
                  : context.read<HistoryCubit>().currentDesigns;

              if (displayDesigns.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(AppImages.noImage),
                      Text(
                        S.of(context).noHistory,
                        style: AppTextStyles.title20Bold,
                      ),
                      Text(
                        S.of(context).noHistoryDesc,
                        style: AppTextStyles.body16Regular.copyWith(
                          color: AppColors.greyColor.withValues(alpha: 0.6),
                        ),
                      ),
                    ],
                  ),
                );
              }

              return ListView.separated(
                controller: _scrollController,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                itemCount:
                    displayDesigns.length +
                    (state is HistoryPaginationLoading ? 1 : 0),
                separatorBuilder: (context, index) => SizedBox(height: 12.h),
                itemBuilder: (context, index) {
                  // Pagination loader at the bottom
                  if (index >= displayDesigns.length) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        child: const CircularProgressIndicator(),
                      ),
                    );
                  }

                  final item = displayDesigns[index];

                  String formatGenerationType(String? type) {
                    if (type == null || type.isEmpty) return S.of(context).historyTypeDefault;
                    switch (type) {
                      case 'generate_design':
                        return S.of(context).historyTypeGenerateDesign;
                      case 'restyle_design':
                        return S.of(context).historyTypeRestyleDesign;
                      case 'full_home':
                        return S.of(context).historyTypeFullHome;
                      case 'mask_edit':
                        return S.of(context).historyTypeMaskEdit;
                      case 'mask_replace':
                        return S.of(context).historyTypeMaskReplace;
                      case 'mask_remove':
                        return S.of(context).historyTypeMaskRemove;
                      default:
                        return type.replaceAll('_', ' ').replaceFirst(
                              type[0],
                              type[0].toUpperCase(),
                            );
                    }
                  }

                  final title = formatGenerationType(item.generationType);

                  return CustomHistoryContainer(
                    imageUrl: item.imageUrl,
                    title: title,
                    description: item.prompt ?? title,
                    date: item.createdAt,
                    onTap: () {
                      final groupedDesigns = item.generationType == 'full_home' &&
                              item.groupId != null
                          ? context.read<HistoryCubit>().groupedDesigns[item.groupId]
                          : null;

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HistoryDetailsView(
                            title: title,
                            imageUrl: item.imageUrl,
                            designId: item.id,
                            prompt: item.prompt,
                            generationType: item.generationType,
                            groupedDesigns: groupedDesigns,
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            }

            // Initial state
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
