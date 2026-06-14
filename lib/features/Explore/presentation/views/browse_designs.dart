import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/widgets/custom_appbar.dart';
import 'package:sammly/features/Explore/cubit/static_designs_cubit.dart';
import 'package:sammly/features/Explore/cubit/static_designs_states.dart';
import 'package:sammly/features/explore/presentation/widgets/design_grid_item.dart';
import 'package:sammly/core/routing/routes.dart';
import 'package:sammly/core/constant/app_images.dart';
import 'package:sammly/core/theme/text_styles.dart';
import 'package:sammly/features/favorite/presentation/cubit/favorite_cubit.dart';
import 'package:sammly/features/favorite/presentation/cubit/favorite_state.dart';
const Color kTextDark = Color(0xFF2E2E2E);

class BrowseDesigns extends StatefulWidget {
  final String? room;

  const BrowseDesigns({super.key, this.room});

  @override
  State<BrowseDesigns> createState() => _BrowseDesignsState();
}

class _BrowseDesignsState extends State<BrowseDesigns> {
  final List<String> _filters = [
    'All',
    'Mid-century modern',
    'Bohemian',
    'Rustic',
    'Coastal',
    'Traditional',
  ];
  String _selectedFilter = 'All';

  final ScrollController _scrollController = ScrollController();

  /// Map UI filter label to API style value.
  String _styleApiValue(String uiLabel) {
    if (uiLabel == 'All') return 'all';
    return uiLabel.toLowerCase().replaceAll('-', ' ');
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);

    // Fetch first page with room and default style
    context.read<StaticDesignsCubit>().fetchStaticDesigns(
      room: widget.room,
      style: _styleApiValue(_selectedFilter),
    );
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
      final cubit = context.read<StaticDesignsCubit>();
      if (cubit.hasMore && cubit.state is! StaticDesignsPaginationLoading) {
        cubit.loadMore();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg1Color,
      appBar: const CustomAppbar(title: 'Browse Categories'),
      body: SafeArea(
        child: BlocListener<FavoriteCubit, FavoriteState>(
          listener: (context, state) {
            if (state is FavoriteToggleError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            } else if (state is FavoriteToggleSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: AppColors.primaryColor,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          },
          child: Column(
            children: [
              _buildFilterBar(),
              SizedBox(height: 16.h),
              Expanded(child: _buildDesignGrid()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterBar() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: _filters.map((filter) {
          final isSelected = filter == _selectedFilter;
          return Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: GestureDetector(
              onTap: () {
                if (_selectedFilter == filter) return;
                setState(() {
                  _selectedFilter = filter;
                });
                context.read<StaticDesignsCubit>().changeStyle(
                  _styleApiValue(filter),
                );
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  gradient: isSelected
                      ? const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            AppColors.primaryColor,
                            AppColors.secondaryColor,
                          ],
                        )
                      : null,
                  color: isSelected ? null : const Color(0xFFEFF5F5),
                ),
                child: Text(
                  filter,
                  style: TextStyle(
                    color: isSelected ? Colors.white : const Color(0xFF4A6565),
                    fontSize: 14.sp,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    fontFamily: 'Manrope',
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildDesignGrid() {
    return BlocBuilder<StaticDesignsCubit, StaticDesignsState>(
      builder: (context, state) {
        // Initial loading
        if (state is StaticDesignsLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        // Error
        if (state is StaticDesignsError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 48.sp,
                  color: AppColors.greyColor,
                ),
                SizedBox(height: 12.h),
                Text(
                  state.message,
                  style: TextStyle(
                    color: AppColors.greyColor,
                    fontSize: 14.sp,
                    fontFamily: 'Manrope',
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 12.h),
                TextButton(
                  onPressed: () =>
                      context.read<StaticDesignsCubit>().fetchStaticDesigns(
                        room: widget.room,
                        style: _styleApiValue(_selectedFilter),
                      ),
                  child: Text(
                    'Retry',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 14.sp,
                      fontFamily: 'Manrope',
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        // Loaded or pagination loading
        if (state is StaticDesignsLoaded ||
            state is StaticDesignsPaginationLoading) {
          final designs = state is StaticDesignsLoaded
              ? state.designs
              : context.read<StaticDesignsCubit>().currentDesigns;

          if (designs.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(AppImages.noImage),
                  Text('No Designs', style: AppTextStyles.title20Bold),
                  Text(
                    'No designs found',
                    style: AppTextStyles.body16Regular.copyWith(
                      color: AppColors.greyColor.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            );
          }

          final isPaginationLoading = state is StaticDesignsPaginationLoading;

          return GridView.builder(
            controller: _scrollController,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12.w,
              mainAxisSpacing: 12.h,
              childAspectRatio: 1.0,
            ),
            itemCount: designs.length + (isPaginationLoading ? 1 : 0),
            itemBuilder: (context, index) {
              // Pagination loader
              if (index >= designs.length) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    child: const CircularProgressIndicator(),
                  ),
                );
              }

              final design = designs[index];
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.browseDesignDetailsView,
                    arguments: design.id,
                  );
                },
                child: BlocBuilder<FavoriteCubit, FavoriteState>(
                  builder: (context, favState) {
                    final isFav = context.read<FavoriteCubit>().isFavorite(design.id);
                    return DesignGridItem(
                      imageUrl: design.imageUrl,
                      initialIsLiked: isFav,
                      onFavoriteToggled: (isLiked) {
                        context.read<FavoriteCubit>().toggleFavorite(design.id, !isLiked);
                        context.read<StaticDesignsCubit>().toggleFavoriteLocal(
                          design.id,
                        );
                      },
                    );
                  },
                ),
              );
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
