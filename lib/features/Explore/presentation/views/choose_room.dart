import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/constant/app_images.dart';
import 'package:sammly/core/constant/app_strings.dart';
import 'package:sammly/core/theme/text_styles.dart';
import 'package:sammly/core/widgets/custom_appbar.dart';
import 'package:sammly/features/Explore/presentation/views/browse_designs.dart';

class ExploreView extends StatelessWidget {
  const ExploreView({super.key});

  @override
  Widget build(BuildContext context) {
    // قائمة الغرف المتاحة في الـ Explore
    final List<Map<String, String>> exploreRooms = [
      {'name': AppStrings.bedroom, 'image': AppImages.roomBedroom},
      {'name': AppStrings.diningRoom, 'image': AppImages.roomDining},
      {'name': AppStrings.kitchen, 'image': AppImages.roomKitchen},
      {'name': AppStrings.bathroom, 'image': AppImages.roomBathroom},
      {
        'name': AppStrings.livingRoom,
        'image': AppImages.roomLivingBohoTraditional,
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      // الـ AppBar العلوي الموحد عندك في البروجكت
      appBar: const CustomAppbar(
        title: 'Select Room',
        // لو الشاشة دي رئيسية في الـ BottomNavBar شيل سهم الـ back لو مش عاوزه
      ),
      body: ListView.separated(
        // البادينج متناسق جداً مع أبعاد شاشات الأبلكيشن
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        itemCount: exploreRooms.length,
        separatorBuilder: (context, index) =>
            SizedBox(height: 20.h), // مسافة أمان بين الكروت
        itemBuilder: (context, index) {
          final room = exploreRooms[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BrowseDesigns()),
              );
            },
            child: Container(
              height: 240.h, // طول الكارد متناسق مع أبعاد فيجما بالملي
              decoration: BoxDecoration(
                color: AppColors.roomItemBgColor,
                borderRadius: BorderRadius.circular(
                  24.r,
                ), // حواف دائرية ناعمة زي الصورة
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 1. صورة الغرفة
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(24.r),
                      ),
                      child: Image.asset(
                        room['image']!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey.shade100,
                            child: const Icon(
                              Icons.image_not_supported_outlined,
                              color: Colors.grey,
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  // 2. شريط اسم الغرفة السفلي الأبيض النظيف
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors
                          .whiteColor, // خلفية بيضاء سادة ونظيفة زي الصورة
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(24.r),
                      ),
                    ),
                    child: Text(
                      room['name']!,
                      style: AppTextStyles.title18SemiBold.copyWith(
                        color: const Color(0xFF2E2E2E), // لون نص واضح
                        fontSize: 18.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
