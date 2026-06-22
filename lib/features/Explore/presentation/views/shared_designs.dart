import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/constant/app_images.dart';
import 'package:sammly/features/Explore/cubit/explorecubit.dart';
import 'package:sammly/features/Explore/cubit/explorestates.dart';
import 'package:sammly/features/Explore/presentation/widgets/design_grid_item.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sammly/core/routing/routes.dart';
import 'package:sammly/core/widgets/custom_appbar.dart';
import 'package:sammly/core/theme/text_styles.dart';
import 'package:sammly/generated/l10n.dart';
import 'package:sammly/features/favorite/presentation/cubit/favorite_cubit.dart';
import 'package:sammly/features/favorite/presentation/cubit/favorite_state.dart';

class SharedDesignsView extends StatefulWidget {
  const SharedDesignsView({super.key});

  @override
  State<SharedDesignsView> createState() => _SharedDesignsViewState();
}

class _SharedDesignsViewState extends State<SharedDesignsView>
    with TickerProviderStateMixin {
  // Sort options
  final List<String> _sortOptions = ['likes', 'latest'];
  String _selectedSort = 'likes';

  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  late final AnimationController _gridAnimController;

  String _getSortLabel(BuildContext context, String sort) {
    return sort == 'likes' ? S.of(context).mostLiked : S.of(context).mostRecent;
  }

  @override
  void initState() {
    super.initState();
    _gridAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _scrollController.addListener(_onScroll);

    // Fetch initial data only if empty
    final cubit = context.read<ExploreCubit>();
    if (cubit.currentDesigns.isEmpty) {
      cubit.fetchExplore(sort: _selectedSort);
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _gridAnimController.forward();
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _searchController.dispose();
    _gridAnimController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      final cubit = context.read<ExploreCubit>();
      if (cubit.hasMore && cubit.state is! ExplorePaginationLoading) {
        cubit.loadMore();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: BlocListener<FavoriteCubit, FavoriteState>(
          listener: (context, state) {
            if (state is FavoriteToggleSuccess) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: AppColors.primaryColor,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
            } else if (state is FavoriteToggleError) {
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
          child: SafeArea(
            child: Column(
              children: [
                CustomAppbar(
                  title: S.of(context).sharedDesigns,
                  backgroundColor: Colors.transparent,
                ),
                SizedBox(height: 4.h),
                _buildSearchBar(),
                SizedBox(height: 16.h),
                _buildSortBar(),
                SizedBox(height: 12.h),
                Expanded(child: _buildDesignGrid()),
              ],
            ),
          ),
        ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
        height: 50.h,
        decoration: BoxDecoration(
          color: AppColors.bg1Color,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: AppColors.secondaryColor.withValues(alpha: 0.15),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryColor.withValues(alpha: 0.06),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: TextField(
          controller: _searchController,
          onSubmitted: (value) {
            final query = value.trim().isEmpty ? null : value.trim();
            context.read<ExploreCubit>().searchDesigns(query);
            _gridAnimController.reset();
            _gridAnimController.forward();
          },
          decoration: InputDecoration(
            hintText: S.of(context).searchDesigns,
            hintStyle: TextStyle(
              color: AppColors.greyColor.withValues(alpha: 0.6),
              fontSize: 14.sp,
              fontFamily: 'Manrope',
              fontWeight: FontWeight.w400,
            ),
            prefixIcon: Padding(
              padding: EdgeInsets.all(13.w),
              child: SvgPicture.asset(AppImages.searchIcon).withAppGradient(),
            ),
            suffixIcon: _searchController.text.isNotEmpty
                ? IconButton(
                    icon: Icon(
                      Icons.clear,
                      size: 18.sp,
                      color: AppColors.greyColor,
                    ),
                    onPressed: () {
                      _searchController.clear();
                      context.read<ExploreCubit>().searchDesigns(null);
                      _gridAnimController.reset();
                      _gridAnimController.forward();
                      setState(() {});
                    },
                  )
                : null,
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 15.h),
          ),
          onChanged: (_) => setState(() {}),
        ),
      ),
    );
  }

  Widget _buildSortBar() {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Row(
          children: _sortOptions.map((option) {
            final isSelected = option == _selectedSort;
            return Padding(
              padding: EdgeInsetsDirectional.only(end: 8.w),
              child: GestureDetector(
                onTap: () {
                  if (_selectedSort == option) return;
                  setState(() {
                    _selectedSort = option;
                  });
                  context.read<ExploreCubit>().changeSort(_selectedSort);
                  _gridAnimController.reset();
                  _gridAnimController.forward();
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 8.h,
                  ),
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
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        option == 'likes'
                            ? Icons.favorite_rounded
                            : Icons.access_time_rounded,
                        color: isSelected
                            ? Colors.white
                            : const Color(0xFF4A6565),
                        size: 14.sp,
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        _getSortLabel(context, option),
                        style: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : const Color(0xFF4A6565),
                          fontSize: 14.sp,
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.w500,
                          fontFamily: 'Manrope',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildDesignGrid() {
    return BlocBuilder<ExploreCubit, ExploreState>(
      builder: (context, state) {
        // Initial loading
        if (state is ExploreLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        // Error
        if (state is ExploreError) {
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
                  onPressed: () => context.read<ExploreCubit>().fetchExplore(
                    sort: _selectedSort,
                  ),
                  child: Text(
                    S.of(context).retry,
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
        if (state is ExploreLoaded || state is ExplorePaginationLoading) {
          final designs = state is ExploreLoaded
              ? state.designs
              : context.read<ExploreCubit>().currentDesigns;

          if (designs.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(AppImages.noImage),
                  Text(
                    S.of(context).noSharedDesigns,
                    style: AppTextStyles.title20Bold,
                  ),
                  Text(
                    S.of(context).noSharedDesignsFound,
                    style: AppTextStyles.body16Regular.copyWith(
                      color: AppColors.greyColor.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            );
          }

          final isPaginationLoading = state is ExplorePaginationLoading;

          return CustomScrollView(
            controller: _scrollController,
            cacheExtent: 9999,
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                sliver: SliverMasonryGrid.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12.h,
                  crossAxisSpacing: 12.w,
                  childCount: designs.length,
                  itemBuilder: (context, index) {
                    final design = designs[index];

                    // Staggered height
                    final List<double> itemHeights = [
                      1.2,
                      0.85,
                      1.4,
                      0.9,
                      1.0,
                      1.3,
                      0.8,
                      1.1,
                    ];
                    final baseWidth =
                        (MediaQuery.of(context).size.width - 44.w) / 2;
                    final itemHeight =
                        baseWidth * itemHeights[index % itemHeights.length];

                    final gridItem = GestureDetector(
                      onTap: () async {
                        await Navigator.pushNamed(
                          context,
                          AppRoutes.sharedDesignDetailsView,
                          arguments: design,
                        );
                      },
                      child: SizedBox(
                        height: itemHeight,
                        child: BlocBuilder<FavoriteCubit, FavoriteState>(
                          builder: (context, favState) {
                         
                            return DesignGridItem(
                              imageUrl: design.imageUrl,
                              initialIsFavorited: design.isFavorited,
                              onFavoriteToggled: (isFavorited) {
                                context.read<FavoriteCubit>().toggleFavorite(
                                  design.id,
                                  !isFavorited,
                                );
                                context
                                    .read<ExploreCubit>()
                                    .toggleFavoriteLocal(design.id);
                              },
                            );
                          },
                        ),
                      ),
                    );

                    // Only animate the first 8 items for performance
                    if (index < 8) {
                      final delay = index * 0.12;
                      final animation = Tween<double>(begin: 0.0, end: 1.0)
                          .animate(
                            CurvedAnimation(
                              parent: _gridAnimController,
                              curve: Interval(
                                delay.clamp(0.0, 0.8),
                                (delay + 0.4).clamp(0.0, 1.0),
                                curve: Curves.easeOutCubic,
                              ),
                            ),
                          );
                      return AnimatedBuilder(
                        animation: animation,
                        builder: (context, child) {
                          return Opacity(
                            opacity: animation.value,
                            child: Transform.translate(
                              offset: Offset(0, 30 * (1 - animation.value)),
                              child: child,
                            ),
                          );
                        },
                        child: gridItem,
                      );
                    }

                    return gridItem;
                  },
                ),
              ),
              if (isPaginationLoading)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    child: const Center(child: CircularProgressIndicator()),
                  ),
                ),
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
