import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/routing/routes.dart';
import 'package:sammly/features/favorite/data/models/favorite_response_model.dart';
import 'package:sammly/features/favorite/presentation/cubit/favorite_cubit.dart';
import 'package:sammly/features/favorite/presentation/cubit/favorite_state.dart';
import 'package:sammly/features/favorite/presentation/cubit/favorite_toggle_cubit.dart';
import 'package:sammly/features/favorite/presentation/cubit/favorite_toggle_state.dart';
import 'package:sammly/features/favorite/presentation/views/widgets/favorite_heart_item.dart';

class FavoriteGridView extends StatefulWidget {
  final List<FavoriteDesignModel> designs;
  final bool hasMore;

  const FavoriteGridView({
    super.key,
    required this.designs,
    required this.hasMore,
  });

  @override
  State<FavoriteGridView> createState() => _FavoriteGridViewState();
}

class _FavoriteGridViewState extends State<FavoriteGridView> {
  late final ScrollController _scrollController;

  // Heights to simulate staggered look
  final List<double> _itemHeights = [
    1.2,
    0.85,
    1.4,
    0.9,
    1.0,
    1.3,
    0.8,
    1.1,
  ];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);

    // Seed all current favorite designs into the global toggle cubit
    final toggleCubit = context.read<FavoriteToggleCubit>();
    for (final design in widget.designs) {
      toggleCubit.seedFavoriteStatus(design.id, true);
    }
  }

  @override
  void didUpdateWidget(covariant FavoriteGridView oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Seed any newly loaded designs (pagination)
    if (widget.designs.length != oldWidget.designs.length) {
      final toggleCubit = context.read<FavoriteToggleCubit>();
      for (final design in widget.designs) {
        toggleCubit.seedFavoriteStatus(design.id, true);
      }
    }
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<FavoriteCubit>().loadMoreFavorites();
    }
  }

  @override
  Widget build(BuildContext context) {
    final baseWidth = (MediaQuery.of(context).size.width - 44.w) / 2;
    final isPaginationLoading =
        context.read<FavoriteCubit>().state is FavoritePaginationLoading;
    final itemCount =
        widget.designs.length + (isPaginationLoading ? 1 : 0);

    return Expanded(
      child: MasonryGridView.builder(
        controller: _scrollController,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        mainAxisSpacing: 12.h,
        crossAxisSpacing: 12.w,
        itemCount: itemCount,
        itemBuilder: (context, index) {
          // Show loading indicator at the bottom
          if (index >= widget.designs.length) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primaryColor,
                ),
              ),
            );
          }

          final design = widget.designs[index];
          final itemHeight =
              baseWidth * _itemHeights[index % _itemHeights.length];

          return BlocBuilder<FavoriteToggleCubit, FavoriteToggleState>(
            buildWhen: (prev, curr) {
              if (curr is FavoriteToggleUpdated) {
                return curr.designId == design.id;
              }
              if (curr is FavoriteToggleReverted) {
                return curr.designId == design.id;
              }
              return false;
            },
            builder: (context, state) {
              final isLiked = context
                  .read<FavoriteToggleCubit>()
                  .isFavorited(design.id);

              // If the item was un-favorited, hide it from the grid
              if (!isLiked) return const SizedBox.shrink();

              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.sharedDesignDetailsView,
                    arguments: {
                      'imageUrl': design.imageUrl,
                      'designId': design.id,
                    },
                  );
                },
                child: SizedBox(
                  height: itemHeight,
                  child: FavoriteHeartItem(
                    imageUrl: design.imageUrl,
                    designId: design.id,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}