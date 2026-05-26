import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/widgets/custom_appbar.dart';
import 'package:sammly/features/explore/presentation/widgets/design_grid_item.dart';
import 'package:sammly/core/routing/routes.dart';

const Color kTextDark = Color(0xFF2E2E2E);

class BrowseDesigns extends StatefulWidget {
  const BrowseDesigns({super.key});

  @override
  State<BrowseDesigns> createState() => _BrowseDesignsState();
}

class _BrowseDesignsState extends State<BrowseDesigns> {
  final List<String> _filters = [
    'All',
    'Art deco',
    'Bohemian',
    'Coastal',
    'Contemporary',
  ];
  String _selectedFilter = 'All';

  final List<String> _designImageUrls = [
    'https://images.unsplash.com/photo-1598928506311-c55ded91a20c?q=80&w=600&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1513694203232-719a280e022f?q=80&w=600&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1616046229478-9901c5536a45?q=80&w=600&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?q=80&w=600&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1617104678098-de229db51175?q=80&w=600&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1634712282287-14ed57b9cc89?q=80&w=600&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?q=80&w=600&auto=format&fit=crop',
    'https://images.unsplash.com/photo-1616486338812-3dadae4b4ace?q=80&w=600&auto=format&fit=crop',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg1Color,
      appBar: const CustomAppbar(title: 'Explore'),
      body: SafeArea(
        child: Column(
          children: [
            _buildFilterBar(),
            SizedBox(height: 16.h),
            Expanded(child: _buildDesignGrid()),
          ],
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
    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
        childAspectRatio: 1.0,
      ),
      itemCount: _designImageUrls.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              AppRoutes.browseDesignDetailsView,
              arguments: _designImageUrls[index],
            );
          },
          child: DesignGridItem(imageUrl: _designImageUrls[index]),
        );
      },
    );
  }
}
