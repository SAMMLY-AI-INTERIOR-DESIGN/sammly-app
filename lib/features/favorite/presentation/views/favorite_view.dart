import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/constant/app_strings.dart';
import 'package:sammly/core/widgets/custom_appbar.dart';
import 'package:sammly/features/favorite/data/repo/favorite_repo.dart';
import 'package:sammly/features/favorite/presentation/cubit/favorite_cubit.dart';
import 'package:sammly/features/favorite/presentation/cubit/favorite_state.dart';
import 'package:sammly/features/favorite/presentation/cubit/favorite_toggle_cubit.dart';
import 'package:sammly/features/favorite/presentation/cubit/favorite_toggle_state.dart';
import 'package:sammly/features/favorite/presentation/views/widgets/favorite_grid_view.dart';
import 'package:sammly/features/favorite/presentation/views/widgets/filter_bar.dart';
import 'package:sammly/features/favorite/presentation/views/widgets/no_favorite_widget.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoriteCubit(FavoriteRepo())..getFavorites(),
      child: BlocListener<FavoriteToggleCubit, FavoriteToggleState>(
        listener: (context, state) {
          if (state is FavoriteToggleReverted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 2),
              ),
            );
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.whiteColor,
          appBar: CustomAppbar(title: AppStrings.favorite),
          body: SafeArea(
            child: BlocBuilder<FavoriteCubit, FavoriteState>(
              builder: (context, state) {
                return Column(
                  children: [
                    SizedBox(height: 16.h),
                    const FilterBar(),
                    SizedBox(height: 16.h),
                    _buildBody(state),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(FavoriteState state) {
    if (state is FavoriteLoading) {
      return const Expanded(
        child: Center(
          child: CircularProgressIndicator(
            color: AppColors.primaryColor,
          ),
        ),
      );
    }

    if (state is FavoriteError) {
      return Expanded(
        child: Center(
          child: Text(
            state.message,
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    if (state is FavoriteEmpty) {
      return const NoFavoriteWidget();
    }

    if (state is FavoriteSuccess) {
      return FavoriteGridView(
        designs: state.designs,
        hasMore: state.hasMore,
      );
    }

    if (state is FavoritePaginationLoading) {
      return FavoriteGridView(
        designs: state.currentDesigns,
        hasMore: true,
      );
    }

    // FavoriteInitial – show nothing while initializing
    return const SizedBox.shrink();
  }
}
