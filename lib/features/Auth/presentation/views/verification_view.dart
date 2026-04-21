import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/constant/app_images.dart';
import 'package:sammly/core/theme/text_styles.dart';
import 'package:sammly/core/widgets/custombutton.dart';
import 'package:sammly/features/Auth/presentation/views/new_password_view.dart';
import 'package:sammly/features/Auth/presentation/widgets/signlogin.dart';

class VerificationView extends StatefulWidget {
  const VerificationView({super.key});

  @override
  State<VerificationView> createState() => _VerificationViewState();
}

class _VerificationViewState extends State<VerificationView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: AppBar(
          backgroundColor: AppColors.whiteColor,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.blackColor,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20.h),

              // 1. اللوجو الملون
              SvgPicture.asset(AppImages.splash, width: 160.w, height: 147.h),
              SizedBox(height: 32.h),

              // 2. مؤشر الخطوات (الخطوة الثانية هي اللي منورة)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) {
                  bool isActive = index == 1; // اندكس 1 يعني الخطوة التانية
                  return Container(
                    width: 30.w,
                    height: 4.h,
                    margin: EdgeInsets.symmetric(horizontal: 4.w),
                    decoration: BoxDecoration(
                      gradient: isActive ? AppColors.primaryGradient : null,
                      color: isActive ? null : AppColors.bg2Color,
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  );
                }),
              ),
              SizedBox(height: 40.h),

              // 3. العناوين
              Text('Verification', style: AppTextStyles.heading28ExtraBold),
              SizedBox(height: 8.h),
              Text(
                'Enter Verification Code',
                style: AppTextStyles.body14Regular.copyWith(
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 40.h),

              // 4. حقول إدخال الكود (OTP)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(4, (index) => _buildOtpBox(context)),
              ),
              SizedBox(height: 40.h),

              // 5. زرار المتابعة
              CustomButton(
                text: 'Verify',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CreateNewPasswordView(),
                    ),
                  );
                },
              ),
              SizedBox(height: 32.h),

              // 6. إعادة إرسال الكود
              SignLogin(
                text1: "Didn't receive the Code?",
                text2: "Resend",
                ontap: () {
                  // Logic إعادة إرسال الكود
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ودجت مساعدة لصندوق الـ OTP
  Widget _buildOtpBox(BuildContext context) {
    return SizedBox(
      height: 60.h,
      width: 60.w,
      child: TextFormField(
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(
              context,
            ).nextFocus(); // بينقل المؤشر للمربع اللي بعده تلقائي
          }
        },
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1, // رقم واحد بس
        style: AppTextStyles.heading28ExtraBold.copyWith(fontSize: 24.sp),
        decoration: InputDecoration(
          counterText: "", // عشان يخفي عداد الحروف (0/1)
          filled: true,
          fillColor: AppColors.bg1Color,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(color: AppColors.bg2Color),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: const BorderSide(
              color: AppColors.primaryColor,
            ), // بياخد لون أزرق لما تدوس عليه
          ),
        ),
      ),
    );
  }
}
