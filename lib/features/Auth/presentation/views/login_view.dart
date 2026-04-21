import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/constant/app_images.dart';
import 'package:sammly/core/theme/text_styles.dart';
import 'package:sammly/core/widgets/custombutton.dart';
import 'package:sammly/features/Auth/presentation/views/forgot_password_view.dart';
import 'package:sammly/features/Auth/presentation/views/signup_view.dart';
import 'package:sammly/features/Auth/presentation/widgets/custom_line.dart';
import 'package:sammly/features/Auth/presentation/widgets/custom_text_field.dart';
import 'package:sammly/features/Auth/presentation/widgets/loginwith.dart';
import 'package:sammly/features/Auth/presentation/widgets/signlogin.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
    final screenHeight = MediaQuery.sizeOf(context).height;

    // 💡 التريكة الجديدة: غلفنا الشاشة بـ GestureDetector
    return GestureDetector(
      onTap: () {
        // السطر ده بيلغي الـ Focus من حقل الإدخال فبالتالي الكيبورد بتنزل
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: SingleChildScrollView(
          // 💡 مسحنا سطر الـ keyboardDismissBehavior من هنا
          // عشان السكرول ملوش دعوة بالكيبورد دلوقتي
          child: SizedBox(
            height:
                screenHeight, // بنجبر الـ Stack ياخد طول الشاشة الأصلي وميتضغطش
            child: Stack(
              children: [
                // 1. الخلفية المتدرجة
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.center,
                      colors: [
                        AppColors.primaryColor,
                        AppColors.secondaryColor,
                      ],
                    ),
                  ),
                ),

                // 2. اللوجو
                Positioned(
                  top: 100.h,
                  left: 0,
                  right: 0,
                  child: SvgPicture.asset(
                    AppImages.splash,
                    width: 256.w,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                ),

                // 3. الكارت الأبيض والفورم
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 700.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      // هنا ضفنا الجريدينت الخفيف بتاع الكارت
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColors.bg1Color, // بيبدأ أبيض أو فاتح جداً من فوق
                          AppColors.bg2Color, // وبيندمج مع الأزرق الفاتح تحت
                          // 💡 تقدر تخليها [AppColors.bg1Color, AppColors.bg2Color]
                          // لو حابب التدرج يكون بين الأزرق الفاتح والأخضر الفاتح زي الخلفية الأصلية
                        ],
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(35.r),
                        topRight: Radius.circular(35.r),
                      ),
                    ),
                    child: SingleChildScrollView(
                      // الـ Scroll الداخلي شغال زي ما هو
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w,
                        vertical: 32.h,
                      ),
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
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ForgotPasswordScreen(),
                                    ),
                                  );
                                },
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  minimumSize: Size.zero,
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
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
                                if (_formKey.currentState!.validate()) {}
                              },
                            ),
                            SizedBox(height: 24.h),

                            const Customline(text: 'Or login with'),
                            SizedBox(height: 24.h),

                            Loginwith(
                              onGoogleTap: () {},
                              onFacebookTap: () {},
                              onAppleTap: () {},
                            ),
                            SizedBox(height: 32.h),

                            SignLogin(
                              text1: "Don't have an account?",
                              text2: "Sign up",
                              ontap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SignUpScreen(),
                                  ),
                                );
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
          ),
        ),
      ),
    );
  }
}
