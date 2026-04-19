import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/constant/app_images.dart';
import 'package:sammly/core/theme/text_styles.dart';
import 'package:sammly/features/Auth/presentation/widgets/custom_line.dart';
import 'package:sammly/features/Auth/presentation/widgets/custom_text_field.dart';
import 'package:sammly/features/Auth/presentation/widgets/custombutton.dart';
import 'package:sammly/features/Auth/presentation/widgets/loginwith.dart';
import 'package:sammly/features/Auth/presentation/widgets/signlogin.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controllers لحفظ الداتا اللي اليوزر بيكتبها
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Stack(
        children: [
          // 1. الجزء العلوي (الخلفية المتدرجة واللوجو)
          Container(
            height: 400.h,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [AppColors.primaryColor, AppColors.secondaryColor],
              ),
            ),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    AppImages.splash, // تأكد إن مسار اللوجو مظبوط في app_images.dart
                    height: 100.h,
                    colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  ),
                  SizedBox(height: 60.h), // مسافة لرفع اللوجو قليلاً
                ],
              ),
            ),
          ),

         
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 620.h, // ارتفاع الكارت الأبيض
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35.r),
                  topRight: Radius.circular(35.r),
                ),
              ),
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                    
                      Text(
                        'Welcome Back',
                        style: AppTextStyles.heading28ExtraBold,
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Login in to your account',
                        style: AppTextStyles.body16Regular,
                      ),
                      SizedBox(height: 32.h),

                    
                      CustomTextField(
                        controller: _emailController,
                        thing: 'Enter your email',
                        preffixicon: Icons.email_outlined,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),

                      // حقل الباسورد
                      CustomTextField(
                        controller: _passwordController,
                        thing: 'Enter your password',
                        preffixicon: Icons.lock_outline,
                        ispassword: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),

                   
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                           
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            'Forgot Password?',
                            style: AppTextStyles.body14Regular,
                          ),
                        ),
                      ),
                      SizedBox(height: 24.h),

                   
                      CustomButton(
                        text: 'Log In',
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                 
                          }
                        },
                      ),
                      SizedBox(height: 24.h),

                      // خط الفاصل
                      const Customline(text: 'Or login with'),
                      SizedBox(height: 24.h),

                      // أيقونات السوشيال ميديا
                      Loginwith(
                        onGoogleTap: () {},
                        onFacebookTap: () {},
                        onAppleTap: () {},
                      ),
                      SizedBox(height: 32.h),

                      // الانتقال لشاشة إنشاء الحساب
                      SignLogin(
                        text1: "Don't have an account?",
                        text2: "Sign up",
                        ontap: () {
                       
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}