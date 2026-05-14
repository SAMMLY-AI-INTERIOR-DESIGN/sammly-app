import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/constant/app_strings.dart';
import 'package:sammly/core/theme/text_styles.dart';

class FilterBar extends StatefulWidget {
  const FilterBar({super.key});

  @override
  State<FilterBar> createState() => _FilterBarState();
}

class _FilterBarState extends State<FilterBar> {

  final List<String> _filters = [
    AppStrings.all,
    AppStrings.bathroom,
    AppStrings.bedroom,
    AppStrings.diningRoom,
    AppStrings.kitchen,
    AppStrings.livingRoom,
  ];
  String _selectedFilter = AppStrings.all;
  
  @override
  Widget build(BuildContext context) {
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
                setState(() {
                  _selectedFilter = filter;
                });
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
  }
}