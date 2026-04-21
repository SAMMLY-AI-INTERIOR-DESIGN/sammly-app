import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/constant/app_images.dart';
import 'package:sammly/core/theme/text_styles.dart';
import 'package:sammly/core/widgets/custombutton.dart';
import 'package:sammly/features/Auth/presentation/views/password_changed_view.dart';
import 'package:sammly/features/Auth/presentation/widgets/custom_text_field.dart';
// استدعي شاشة النجاح اللي عملناها قبل كدا
// import 'package:sammly/features/Auth/presentation/views/password_changed_view.dart';

class CreateNewPasswordView extends StatefulWidget {
  const CreateNewPasswordView({super.key});

  @override
  State<CreateNewPasswordView> createState() => _CreateNewPasswordViewState();
}

class _CreateNewPasswordViewState extends State<CreateNewPasswordView> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

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
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20.h),

                // 1. اللوجو الملون
             SvgPicture.asset(AppImages.splash, width: 160.w, height: 147.h),
                SizedBox(height: 32.h),

                // 2. مؤشر الخطوات (الخطوة الثالثة والأخيرة هي اللي منورة)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (index) {
                    bool isActive = index == 2; // اندكس 2 يعني الخطوة التالتة
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
                Text(
                  'Create new password',
                  style: AppTextStyles.heading28ExtraBold,
                ),
                SizedBox(height: 8.h),
                Text(
                  'Your new password must be unique from those previously used.',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.body14Regular.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 40.h),

                // 4. الباسورد الجديد
                CustomTextField(
                  controller: _passwordController,
                  thing: 'Enter new password',
                  preffixicon: Icons.lock_outline,
                  ispassword: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a new password';
                    } else if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),

                // 5. تأكيد الباسورد
                CustomTextField(
                  controller: _confirmPasswordController,
                  thing: 'Confirm your password',
                  preffixicon: Icons.lock_outline,
                  ispassword: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    } else if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 40.h),

                // 6. زرار الاعتماد
                CustomButton(
                  text: 'Submit',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PasswordChangedScreen(),
                        ),
                      );
                    }
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
