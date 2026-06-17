import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sammly/core/constant/app_colors.dart';

import 'package:sammly/core/theme/text_styles.dart';
import 'package:sammly/features/favorite/presentation/cubit/favorite_cubit.dart';
import 'package:sammly/features/favorite/presentation/cubit/favorite_state.dart';
import 'package:sammly/generated/l10n.dart';

class FilterBar extends StatelessWidget {
  const FilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteCubit, FavoriteState>(
      builder: (context, state) {
        final currentFilter = context.read<FavoriteCubit>().selectedRoom;
        final List<Map<String, String>> filters = [
          {'key': 'all', 'label': S.of(context).all},
          {'key': 'bedroom', 'label': S.of(context).bedroom},
          {'key': 'dining room', 'label': S.of(context).diningRoom},
          {'key': 'living room', 'label': S.of(context).livingRoom},
          {'key': 'kitchen', 'label': S.of(context).kitchen},
          {'key': 'bathroom', 'label': S.of(context).bathroom},
        ];

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            children: filters.map((filter) {
              final key = filter['key']!;
              final label = filter['label']!;
              final isSelected = key == currentFilter;
              return Padding(
                padding: EdgeInsetsDirectional.only(end: 8.w),
                child: GestureDetector(
                  onTap: () {
                    context.read<FavoriteCubit>().changeRoom(key);
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
                              begin: AlignmentDirectional.topStart,
                              end: AlignmentDirectional.bottomEnd,
                              colors: [
                                AppColors.primaryColor,
                                AppColors.secondaryColor,
                              ],
                            )
                          : null,
                      color: isSelected ? null : AppColors.bg1Color,
                    ),
                    child: Text(
                      label,
                      style: isSelected
                          ? AppTextStyles.body16Regular.copyWith(
                              color: AppColors.whiteColor,
                            )
                          : AppTextStyles.body16Regular,
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
