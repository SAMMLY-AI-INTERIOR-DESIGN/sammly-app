import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/constant/app_images.dart';
import 'package:sammly/core/theme/text_styles.dart';
import 'package:sammly/core/widgets/custombutton.dart';
import 'package:sammly/core/routing/routes.dart';
import 'package:sammly/features/Auth/cubit/auth_cubit.dart';
import 'package:sammly/features/Auth/cubit/auth_states.dart';
import 'package:sammly/features/Auth/presentation/widgets/signlogin.dart';
import 'package:pinput/pinput.dart';

class SignUpVerificationView extends StatefulWidget {
  final String email;

  const SignUpVerificationView({super.key, required this.email});

  @override
  State<SignUpVerificationView> createState() => _SignUpVerificationViewState();
}

class _SignUpVerificationViewState extends State<SignUpVerificationView> {
  final TextEditingController _pinController = TextEditingController();

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // --- إعدادات تصميم مربعات الـ OTP (نسخة مطابقة لـ Figma) ---

    // 1. الحالة العادية (المربعات الفاضية)
    final defaultPinTheme = PinTheme(
      width: 48.w, // عرض مناسب عشان الـ 6 مربعات يظبطوا جنب بعض
      height:
          56.h, // أطول من العرض بشوية عشان يدينا شكل المستطيل اللي في التصميم
      textStyle: AppTextStyles.heading28ExtraBold.copyWith(
        fontSize: 24.sp,
        color: AppColors.blackColor,
      ),
      decoration: BoxDecoration(
        color: AppColors.bg1Color, // خلفية بيضاء صافية زي التصميم
        borderRadius: BorderRadius.circular(8.r), // حواف استدارتها أخف
        border: Border.all(
          color: AppColors.activeNavBarBg,
          width: 1,
        ), // إطار بلون خفيف وواضح
      ),
    );

    // 2. حالة الوقوف على المربع (Focused) أو المربع المكتوب فيه (Submitted)
    final activePinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(
        color: AppColors.primaryColor,
        width: 1.5,
      ), // إطار أزرق غامق وسميك شوية
    );

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is VerifyRegisterCodeSuccessState) {
            // JWT is saved, navigate to onboarding/home
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.onboardingView,
              (route) => false,
            );
          } else if (state is VerifyRegisterCodeFailedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMsg),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.whiteColor,
          appBar: AppBar(
            backgroundColor: AppColors.whiteColor,
            elevation: 0,
            scrolledUnderElevation: 0,
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

                // 2. مؤشر الخطوات
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (index) {
                    bool isActive = index == 1;
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
                  'Enter the code sent to\n${widget.email}',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.body14Regular.copyWith(
                    color: AppColors.blackColor,
                  ),
                ),
                SizedBox(height: 40.h),

                // 4. حقول إدخال الكود باستخدام Pinput
                Pinput(
                  length: 6,
                  controller: _pinController,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: activePinTheme, // الإطار بيزرق وإنت واقف عليه
                  submittedPinTheme:
                      activePinTheme, // الإطار بيفضل أزرق بعد ما تكتب الرقم (زي صورة فيجما بالظبط)
                  keyboardType: TextInputType.number,
                  onCompleted: (pin) {
                    debugPrint("OTP Entered: $pin");
                  },
                ),
                SizedBox(height: 40.h),

                // 5. زرار المتابعة
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    if (state is VerifyRegisterCodeLoadingState) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return CustomButton(
                      text: 'Verify',
                      onPressed: () {
                        final code = _pinController.text.trim();
                        if (code.length == 6) {
                          context.read<AuthCubit>().verifyRegisterCode(
                                email: widget.email,
                                code: code,
                              );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please enter the 6-digit code'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                    );
                  },
                ),
                SizedBox(height: 32.h),

                // 6. إعادة إرسال الكود
                SignLogin(
                  text1: "Didn't receive the Code?",
                  text2: "Resend",
                  ontap: () {
                    // Re-trigger registration to resend the code
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Verification code resent to your email'),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
