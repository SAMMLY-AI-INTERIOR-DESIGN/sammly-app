import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/constant/app_strings.dart';
import 'package:sammly/core/theme/text_styles.dart';
import 'package:sammly/features/favorite/presentation/cubit/favorite_cubit.dart';
import 'package:sammly/features/favorite/presentation/cubit/favorite_state.dart';

class FilterBar extends StatelessWidget {
  FilterBar({super.key});

  final List<String> _filters = [
    AppStrings.all,
    AppStrings.bathroom,
    AppStrings.bedroom,
    AppStrings.diningRoom,
    AppStrings.kitchen,
    AppStrings.livingRoom,
  ];
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteCubit, FavoriteState>(
      builder: (context, state) {
        final currentFilter = context.read<FavoriteCubit>().selectedRoom;
        
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            children: _filters.map((filter) {
              final isSelected = filter.toLowerCase() == currentFilter;
              return Padding(
                padding: EdgeInsets.only(right: 8.w),
                child: GestureDetector(
                  onTap: () {
                    context.read<FavoriteCubit>().changeRoom(filter);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      gradient: isSelected
                          ? const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                AppColors.primaryColor,
                                AppColors.secondaryColor,
                              ],
                            )
                          : null,
                      color: isSelected ? null : AppColors.bg1Color,
                    ),
                    child: Text(
                      filter,
                      style: isSelected ? AppTextStyles.body16Regular.copyWith(color: AppColors.whiteColor)
                      : AppTextStyles.body16Regular
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}