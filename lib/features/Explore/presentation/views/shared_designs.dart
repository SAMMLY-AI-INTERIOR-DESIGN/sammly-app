import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/constant/app_images.dart';

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
  final List<Map<String, String>> _designs = [
    {
      'image':
          'https://images.unsplash.com/photo-1598928506311-c55ded91a20c?q=80&w=600&auto=format&fit=crop',
      'user': 'Saleh Khalifa',
      'likes': '34',
    },
    {
      'image':
          'https://images.unsplash.com/photo-1513694203232-719a280e022f?q=80&w=600&auto=format&fit=crop',
      'user': 'Abdallah Khaled',
      'likes': '52',
    },
    {
      'image':
          'https://images.unsplash.com/photo-1616046229478-9901c5536a45?q=80&w=600&auto=format&fit=crop',
      'user': 'Mohamed Yousry',
      'likes': '18',
    },
    {
      'image':
          'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?q=80&w=600&auto=format&fit=crop',
      'user': 'Fatma Salah',
      'likes': '67',
    },
    {
      'image':
          'https://images.unsplash.com/photo-1617104678098-de229db51175?q=80&w=600&auto=format&fit=crop',
      'user': 'Youssef Ali',
      'likes': '29',
    },
    {
      'image':
          'https://images.unsplash.com/photo-1634712282287-14ed57b9cc89?q=80&w=600&auto=format&fit=crop',
      'user': 'Sara ahmed',
      'likes': '41',
    },
    {
      'image':
          'https://images.unsplash.com/photo-1593006440268-b7654b9d5c80?q=80&w=600&auto=format&fit=crop',
      'user': 'Khaled Mostafa',
      'likes': '15',
    },
    {
      'image':
          'https://images.unsplash.com/photo-1616486338812-3dadae4b4ace?q=80&w=600&auto=format&fit=crop',
      'user': 'Dina Farouk',
      'likes': '73',
    },
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
              _buildCustomAppBar(),
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

  Widget _buildCustomAppBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      child: Row(
        children: [
          // زر الرجوع
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(12.r),
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.arrow_back_ios_new,
                  color: AppColors.blackColor,
                  size: 18.sp,
                ),
              ),
            ),
          ),
          const Spacer(),
          // العنوان
          Text(
            'Shared Designs',
            style: TextStyle(
              color: AppColors.blackColor,
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              fontFamily: 'Manrope',
              letterSpacing: -0.3,
            ),
          ),
          const Spacer(),
          // spacer شفّاف عشان العنوان يكون بالمنتصف
          SizedBox(width: 34.w),
        ],
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
              child: SvgPicture.asset(
                AppImages.searchIcon,
              ).withAppGradient(),
            ),
            suffixIcon: Padding(
              padding: EdgeInsets.all(13.w),
              child: Icon(
                Icons.tune_rounded,
                color: AppColors.primaryColor.withOpacity(0.5),
                size: 20.sp,
              ),
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
              padding: EdgeInsets.only(right: 10.w),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedSort = option;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOutCubic,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 10.h,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.r),
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
                    color: isSelected ? null : Colors.white.withOpacity(0.7),
                    border: isSelected
                        ? null
                        : Border.all(
                            color: AppColors.greyColor.withOpacity(0.15),
                            width: 1,
                          ),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: AppColors.primaryColor.withOpacity(0.3),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ]
                        : [],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        option == 'Most liked'
                            ? Icons.favorite_rounded
                            : Icons.access_time_rounded,
                        color: isSelected ? Colors.white : AppColors.greyColor,
                        size: 14.sp,
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        option,
                        style: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : AppColors.blackColor,
                          fontSize: 13.sp,
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
      child: GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12.w,
          mainAxisSpacing: 14.h,
          childAspectRatio: 0.68,
        ),
        itemCount: _designs.length,
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
            child: SharedDesignCard(
              imageUrl: _designs[index]['image']!,
              userName: _designs[index]['user']!,
              likesCount: _designs[index]['likes']!,
            ),
          );
        },
      ),
    );
  }
}

// --- ويدجت الكارت المنفصلة ---
class SharedDesignCard extends StatefulWidget {
  final String imageUrl;
  final String userName;
  final String likesCount;

  const SharedDesignCard({
    super.key,
    required this.imageUrl,
    required this.userName,
    required this.likesCount,
  });

  @override
  State<SharedDesignCard> createState() => _SharedDesignCardState();
}

class _SharedDesignCardState extends State<SharedDesignCard>
    with SingleTickerProviderStateMixin {
  bool _isLiked = false;
  late AnimationController _likeAnimController;
  late Animation<double> _likeScaleAnim;

  @override
  void initState() {
    super.initState();
    _likeAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _likeScaleAnim =
        TweenSequence<double>([
          TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.4), weight: 50),
          TweenSequenceItem(tween: Tween(begin: 1.4, end: 1.0), weight: 50),
        ]).animate(
          CurvedAnimation(parent: _likeAnimController, curve: Curves.easeInOut),
        );
  }

  @override
  void dispose() {
    _likeAnimController.dispose();
    super.dispose();
  }

  void _toggleLike() {
    setState(() {
      _isLiked = !_isLiked;
    });
    if (_isLiked) {
      _likeAnimController.forward(from: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
          BoxShadow(
            color: AppColors.secondaryColor.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // الهيدر: الأيقونة والاسم
          Padding(
            padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 0),
            child: Row(
              children: [
                // أفاتار بحدود gradient
                Container(
                  padding: EdgeInsets.all(1.5.w),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primaryColor,
                        AppColors.secondaryColor,
                      ],
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 11.r,
                    backgroundColor: Colors.white,
                    child: ClipOval(
                      child: Image.asset(
                        AppImages.defaultprofile,
                        height: 20.sp,
                        width: 20.sp,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 6.w),
                Expanded(
                  child: Text(
                    widget.userName,
                    style: TextStyle(
                      fontSize: 11.5.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.blackColor,
                      fontFamily: 'Manrope',
                      letterSpacing: -0.1,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8.h),

          // الصورة في المنتصف
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14.r),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // الصورة
                    Image.network(
                      widget.imageUrl,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return _buildShimmer();
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: AppColors.bg1Color,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.image_not_supported_outlined,
                                color: AppColors.greyColor.withOpacity(0.4),
                                size: 28.sp,
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                'No image',
                                style: TextStyle(
                                  color: AppColors.greyColor.withOpacity(0.5),
                                  fontSize: 10.sp,
                                  fontFamily: 'Manrope',
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),

                    // تدرج لوني سفلي خفيف لتحسين قراءة الفوتر
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      height: 50.h,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.25),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 8.h),

          // الفوتر: اللايكات وزرار السهم
          Padding(
            padding: EdgeInsets.fromLTRB(12.w, 0, 10.w, 10.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // زرار ورقم اللايك
                GestureDetector(
                  onTap: _toggleLike,
                  child: Row(
                    children: [
                      ScaleTransition(
                        scale: _likeScaleAnim,
                        child: SvgPicture.asset(
                          _isLiked
                              ? 'assets/images/heartFilled.svg'
                              : 'assets/images/heartOutline.svg',
                          width: 16.w,
                        ),
                      ),
                      SizedBox(width: 5.w),
                      Text(
                        _isLiked
                            ? '${int.parse(widget.likesCount) + 1}'
                            : widget.likesCount,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: _isLiked
                              ? AppColors.primaryColor
                              : AppColors.greyColor,
                          fontFamily: 'Manrope',
                        ),
                      ),
                    ],
                  ),
                ),

                // زرار المشاهدة
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        AppColors.primaryColor,
                        AppColors.secondaryColor,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.arrow_forward_rounded,
                        color: Colors.white,
                        size: 12.sp,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Shimmer / placeholder أثناء تحميل الصورة
  Widget _buildShimmer() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14.r),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.bg1Color,
            AppColors.bg2Color.withOpacity(0.5),
            AppColors.bg1Color,
          ],
        ),
      ),
      child: Center(
        child: SizedBox(
          width: 24.w,
          height: 24.w,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: AppColors.secondaryColor.withOpacity(0.5),
          ),
        ),
      ),
    );
  }
}
