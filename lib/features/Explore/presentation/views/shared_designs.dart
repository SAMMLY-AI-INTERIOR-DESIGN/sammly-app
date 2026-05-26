import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/constant/app_images.dart';
import 'package:sammly/features/Explore/presentation/widgets/design_grid_item.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sammly/core/routing/routes.dart';
import 'package:sammly/core/widgets/custom_appbar.dart';

class SharedDesignsView extends StatefulWidget {
  const SharedDesignsView({super.key});

  @override
  State<SharedDesignsView> createState() => _SharedDesignsViewState();
}

class _SharedDesignsViewState extends State<SharedDesignsView>
    with TickerProviderStateMixin {
  // خيارات الترتيب
  final List<String> _sortOptions = ['Most liked', 'Most recent'];
  String _selectedSort = 'Most liked';

  // داتا وهمية
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

  // Heights to simulate staggered look (will come from DB in future)
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

  late final AnimationController _gridAnimController;

  @override
  void initState() {
    super.initState();
    _gridAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    // بعد بناء الـ frame الأول نشغّل الأنيميشن
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _gridAnimController.forward();
    });
  }

  @override
  void dispose() {
    _gridAnimController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // خلفية متدرجة بدلاً من لون ثابت
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.scafoldBgGradient),
        child: SafeArea(
          child: Column(
            children: [
              // AppBar مخصص
              const CustomAppbar(
                title: 'Shared Designs',
                backgroundColor: Colors.transparent,
              ),
              SizedBox(height: 4.h),

              // 1. شريط البحث
              _buildSearchBar(),
              SizedBox(height: 16.h),

              // 2. الفلاتر (Most liked / Most recent)
              _buildSortBar(),
              SizedBox(height: 12.h),

              // 3. شبكة التصميمات
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
          color: Colors.white.withOpacity(0.85),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: AppColors.secondaryColor.withOpacity(0.15),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryColor.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Search designs...',
            hintStyle: TextStyle(
              color: AppColors.greyColor.withOpacity(0.6),
              fontSize: 14.sp,
              fontFamily: 'Manrope',
              fontWeight: FontWeight.w400,
            ),
            prefixIcon: Padding(
              padding: EdgeInsets.all(13.w),
              child: SvgPicture.asset(AppImages.searchIcon).withAppGradient(),
            ),

            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 15.h),
          ),
        ),
      ),
    );
  }

  Widget _buildSortBar() {
    return Align(
      alignment: Alignment.centerLeft,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Row(
          children: _sortOptions.map((option) {
            final isSelected = option == _selectedSort;
            return Padding(
              padding: EdgeInsets.only(right: 8.w),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedSort = option;
                  });
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
                        option == 'Most liked'
                            ? Icons.favorite_rounded
                            : Icons.access_time_rounded,
                        color: isSelected
                            ? Colors.white
                            : const Color(0xFF4A6565),
                        size: 14.sp,
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        option,
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
    return ScrollConfiguration(
      behavior: const ScrollBehavior().copyWith(overscroll: false),
      child: MasonryGridView.builder(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        mainAxisSpacing: 12.h,
        crossAxisSpacing: 12.w,
        itemCount: _designImageUrls.length,
        itemBuilder: (context, index) {
          // أنيميشن ظهور تدريجي لكل كارت
          final delay = index * 0.12;
          final animation = Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
              parent: _gridAnimController,
              curve: Interval(
                delay.clamp(0.0, 0.8),
                (delay + 0.4).clamp(0.0, 1.0),
                curve: Curves.easeOutCubic,
              ),
            ),
          );

          // Staggered height based on aspect ratio multiplier
          final baseWidth = (MediaQuery.of(context).size.width - 44.w) / 2;
          final itemHeight =
              baseWidth * _itemHeights[index % _itemHeights.length];

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
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.sharedDesignDetailsView,
                  arguments: _designImageUrls[index],
                );
              },
              child: SizedBox(
                height: itemHeight,
                child: DesignGridItem(imageUrl: _designImageUrls[index]),
              ),
            ),
          );
        },
      ),
    );
  }
}
