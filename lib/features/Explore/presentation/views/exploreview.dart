import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExploreView extends StatelessWidget {
  const ExploreView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // أو استخدم AppColors.bg2Color
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
            size: 20.sp,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Explore',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: Colors.black,
            fontFamily: 'Manrope', // الخط المستخدم في مشروعك
          ),
        ),
      ),
      // Extend body عشان الـ Bottom Nav العائم يظهر بشكل شيك فوق الخلفية
      extendBody: true, 
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Column(
          children: [
            _buildExploreCard(
              imageUrl: 'assets/images/explore_categories.png', // مسار صورة الكارد الأول
              title: 'Browse design categories',
              subtitle:
                  'Explore ready-made styles and rooms organized\nby category.',
            ),
            SizedBox(height: 20.h),
            _buildExploreCard(
              imageUrl: 'assets/images/explore_shared.png', // مسار صورة الكارد الثاني
              title: 'Explore shared designs',
              subtitle:
                  'Browse rooms created by other users and get\ninspired.',
            ),
            SizedBox(height: 100.h), // مساحة عشان الكروت متستخباش تحت الـ Bottom Nav
          ],
        ),
      ),
      bottomNavigationBar: const _CustomBottomNavBar(),
    );
  }

  // Widget مخصص للكروت عشان مكررش الكود
  Widget _buildExploreCard({
    required String imageUrl,
    required String title,
    required String subtitle,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF4F7F9), // لون خلفية النص في الكارد (رمادي/أزرق فاتح جداً)
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // جزء الصورة العلوية
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
            child: Container(
              height: 160.h,
              width: double.infinity,
              color: Colors.grey[300], // لون مؤقت لو الصورة مش موجودة
              // TODO: استخدم الصورة بتاعتك هنا بدل الـ Container الفاضي
              // child: Image.asset(imageUrl, fit: BoxFit.cover), 
            ),
          ),
          // جزء النصوص والزرار
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF333333),
                          fontFamily: 'Manrope',
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF7A7A7A),
                          fontFamily: 'Manrope',
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 12.w),
                // أيقونة السهم الدائرية
                Icon(
                  Icons.arrow_circle_right_outlined,
                  color: const Color(0xFF196868), // لون الأيقونة (نفس لون الأساسي بتاعك)
                  size: 28.sp,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// الكلاس الخاص بالـ Bottom Navigation Bar العائم
class _CustomBottomNavBar extends StatelessWidget {
  const _CustomBottomNavBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 30.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF9F7), // لون خلفية الناف بار
        borderRadius: BorderRadius.circular(30.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildNavItem(icon: Icons.home_outlined, isActive: false),
          _buildNavItem(icon: Icons.explore_outlined, label: 'Explore', isActive: true),
          _buildNavItem(icon: Icons.history, isActive: false),
          _buildNavItem(icon: Icons.person_outline, isActive: false),
        ],
      ),
    );
  }

  Widget _buildNavItem({required IconData icon, String? label, required bool isActive}) {
    final activeColor = const Color(0xFF196868); // لون الأيقونة المفعلة
    final inactiveColor = const Color(0xFF196868); // لون الأيقونة غير المفعلة

    if (isActive && label != null) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: const Color(0xFFC9D4E8), // خلفية الزرار المفعل (أزرق/بنفسجي فاتح)
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Row(
          children: [
            Icon(icon, color: activeColor, size: 24.sp),
            SizedBox(width: 8.w),
            Text(
              label,
              style: TextStyle(
                color: activeColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                fontFamily: 'Manrope',
              ),
            ),
          ],
        ),
      );
    }

    return IconButton(
      icon: Icon(icon, color: inactiveColor, size: 26.sp),
      onPressed: () {
        // يمكنك إضافة Navigation هنا للتبديل بين الشاشات
      },
    );
  }
}