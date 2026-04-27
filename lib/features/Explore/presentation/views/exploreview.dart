import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sammly/core/constant/app_images.dart';
import 'package:sammly/features/Explore/presentation/views/browse_designs.dart';

// import 'package:sammly/features/Explore/presentation/views/shared_designs_view.dart';

class ExploreView extends StatelessWidget {
  const ExploreView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            color: Colors.black,
            fontFamily: 'Manrope',
          ),
        ),
      ),
      extendBody: true,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Column(
          children: [
            _buildExploreCard(
              imageUrl: AppImages.explore1,
              title: 'Browse design categories',
              subtitle:
                  'Explore ready-made styles and rooms organized by category.',
              onTap: () {
                // النقل للشاشة الأولى (التصنيفات)
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BrowseDesigns(),
                  ),
                );

                print(
                  "تم الضغط على الكارت الأول",
                ); // مجرد تست لحد ما تعمل الشاشة
              },
            ),
            SizedBox(height: 20.h),
            _buildExploreCard(
              imageUrl: AppImages.explore2,
              title: 'Explore shared designs',
              subtitle: 'Browse rooms created by other users and get inspired.',
              onTap: () {
                // النقل للشاشة التانية (التصميمات المشتركة اللي فيها الـ Grid)
                /* Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SharedDesignsView()),
                );
                */
                print(
                  "تم الضغط على الكارت التاني",
                ); // مجرد تست لحد ما تعمل الشاشة
              },
            ),
            SizedBox(height: 100.h),
          ],
        ),
      ),
    );
  }

  // ضفنا نوع المتغير (VoidCallback) عشان الكود يبقى Clean
  Widget _buildExploreCard({
    required String imageUrl,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    // لفينا الكونتينر بـ GestureDetector عشان يحس باللمس
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFFF4F7F9),
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
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
              child: Image.asset(
                imageUrl,
                height: 179.h,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
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
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF333333),
                            fontFamily: 'Manrope',
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          subtitle,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14.sp,
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
      ),
    );
  }
}
