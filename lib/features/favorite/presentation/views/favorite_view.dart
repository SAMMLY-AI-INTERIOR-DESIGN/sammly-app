import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/constant/app_strings.dart';
import 'package:sammly/core/widgets/custom_appbar.dart';
import 'package:sammly/features/favorite/presentation/cubit/favorite_cubit.dart';
import 'package:sammly/features/favorite/presentation/views/widgets/favorite_grid_view.dart';
import 'package:sammly/features/favorite/presentation/views/widgets/filter_bar.dart';


class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoriteCubit(),
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: CustomAppbar(title: AppStrings.favorite),
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 16.h),
              FilterBar(),
              SizedBox(height: 16.h),
              FavoriteGridView(),
            ],
          ),
        ),
      ),
    );
  }
}
