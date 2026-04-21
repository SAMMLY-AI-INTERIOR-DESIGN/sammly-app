import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart'; // ستحتاج لهذه الباكدج لو الصورة SVG
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/constant/app_images.dart';
import 'package:sammly/core/theme/text_styles.dart';
import 'package:sammly/core/widgets/custombutton.dart';
import 'package:sammly/features/Auth/presentation/views/login_view.dart';

class PasswordChangedScreen extends StatelessWidget {
  const PasswordChangedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 1. الجزء العلوي المدمج (Stack)
              SizedBox(
                height: 200.h, // حددنا ارتفاع مناسب للجزء العلوي بالكامل
                child: Stack(
                  alignment: Alignment.center, // عشان الدائرة تكون في المنتصف
                  children: [
                    // الطبقة الخلفية: الصورة الشفافة
                    SvgPicture.asset(
                      AppImages.successBackground, // مسار الصورة الجديدة في app_images.dart
                      width: double.infinity,
                      fit: BoxFit.contain, // عشان الصورة تحتفظ بنسبتها
                    ),
                    
                    // الطبقة الأمامية: الدائرة المتدرجة بالكود
                    Container(
                      width: 100.r,
                      height: 100.r,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        // الجريدينت الناعم من الأخضر للأزرق
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromARGB(255, 27, 176, 127), // الأخضر
                            AppColors.primaryColor, // الأزرق
                          ],
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                        ),
                        // الظل اللي بيدي عمق
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primaryColor.withValues(alpha: 0.3),
                            blurRadius: 15,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.check_rounded, // علامة الصح ناعمة
                        color: Colors.white, 
                        size: 60.r,
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 32.h),
              
              // 2. النص
              Text(
                'Your password successfully changed',
                textAlign: TextAlign.center,
                style: AppTextStyles.heading28ExtraBold.copyWith(
                  fontSize: 24.sp,
                ),
              ),
              SizedBox(height: 40.h),
              
              // 3. زرار الرجوع للوجين
              CustomButton(
                text: 'Log In',
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                    (route) => false,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}