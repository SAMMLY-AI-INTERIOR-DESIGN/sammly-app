import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sammly/core/constant/app_images.dart';

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
              imageUrl: AppImages.explore1,
              title: 'Browse design categories',
              subtitle:
                  'Explore ready-made styles and rooms organized\nby category.',
            ),
            SizedBox(height: 20.h),
            _buildExploreCard(
              imageUrl: AppImages.explore2,
              title: 'Explore shared designs',
              subtitle:
                  'Browse rooms created by other users and get\ninspired.',
            ),
            SizedBox(
              height: 100.h,
            ), // مساحة عشان الكروت متستخباش تحت الـ Bottom Nav
          ],
        ),
      ),
    );
  }

  // Widget مخصص للكروت عشان مكررش الكود
  // Widget مخصص للكروت عشان مكررش الكود
  Widget _buildExploreCard({
    required String imageUrl,
    required String title,
    required String subtitle,
  }) {
    return Container(
      width: 366.w, // العرض اللي إنت جبته من Figma بالظبط
      decoration: BoxDecoration(
        color: const Color(0xFFF4F7F9), // لون خلفية النص في الكارد
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
            child: Image.asset(
              imageUrl,
              height: 179.h, // الطول اللي إنت جبته من Figma
              width: double.infinity, // عشان تملأ عرض الكارت كله
              fit: BoxFit.cover, // عشان الصورة متتمطش وتحافظ على جودتها
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
                  color: const Color(0xFF196868),
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
