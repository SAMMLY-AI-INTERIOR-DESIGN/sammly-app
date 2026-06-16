import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sammly/core/constant/app_images.dart';
import 'package:sammly/core/widgets/no_data_widget.dart';
import 'package:sammly/features/favorite/presentation/cubit/favorite_cubit.dart';
import 'package:sammly/features/favorite/presentation/cubit/favorite_state.dart';
import 'package:sammly/features/favorite/presentation/views/widgets/favorite_heart_item.dart';
import 'package:sammly/core/routing/routes.dart';
import 'package:sammly/generated/l10n.dart';

class FavoriteGridView extends StatefulWidget {
  const FavoriteGridView({super.key});

  @override
  State<FavoriteGridView> createState() => _FavoriteGridViewState();
}

class _FavoriteGridViewState extends State<FavoriteGridView> {
  final ScrollController _scrollController = ScrollController();

  // Heights to simulate staggered look
  final List<double> _itemHeights = [
    1.2, // tall
    0.85, // short
    1.4, // taller
    0.9, // short
    1.0, // medium
    1.3, // tall
    0.8, // short
    1.1, // medium
  ];

  @override
  void initState() {
    super.initState();
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
      final cubit = context.read<FavoriteCubit>();
      if (cubit.hasMore && cubit.state is! FavoritePaginationLoading) {
        cubit.loadMore();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final baseWidth = (MediaQuery.of(context).size.width - 44.w) / 2;

    return Expanded(
      child: BlocBuilder<FavoriteCubit, FavoriteState>(
        builder: (context, state) {
          if (state is FavoriteLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is FavoriteError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.message),
                  TextButton(
                    onPressed: () =>
                        context.read<FavoriteCubit>().fetchFavorites(),
                    child: Text(S.of(context).retry),
                  ),
                ],
              ),
            );
          }

          final cubit = context.read<FavoriteCubit>();
          final designs = cubit.currentDesigns;

          if (designs.isEmpty && state is! FavoritePaginationLoading) {
            return NoDataWidget(
              image: AppImages.noFavorite,
              title: S.of(context).noFavorites,
              description: S.of(context).noFavoritesDesc,
            );
          }

          return MasonryGridView.builder(
            controller: _scrollController,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            mainAxisSpacing: 12.h,
            crossAxisSpacing: 12.w,
            itemCount:
                designs.length + (state is FavoritePaginationLoading ? 1 : 0),
            itemBuilder: (context, index) {
              if (index >= designs.length) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    child: const CircularProgressIndicator(),
                  ),
                );
              }

              final itemHeight =
                  baseWidth * _itemHeights[index % _itemHeights.length];
              final design = designs[index];

              return GestureDetector(
                key: ValueKey(design.id),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.browseDesignDetailsView,
                    arguments: design.id,
                  );
                },
                child: SizedBox(
                  height: itemHeight,
                  child: FavoriteHeartItem(
                    designId: design.id,
                    imageUrl: design.imageUrl,
                    initialIsLiked: cubit.isFavorite(design.id),
                    onFavoriteToggled: (isLiked) {
                      cubit.toggleFavorite(design.id, !isLiked);
                    },
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
