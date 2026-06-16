import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/constant/app_images.dart';
import 'package:sammly/core/theme/text_styles.dart';
import 'package:sammly/core/widgets/custombutton.dart';
import 'package:sammly/features/Auth/cubit/auth_cubit.dart';
import 'package:sammly/features/Auth/cubit/auth_states.dart';
import 'package:sammly/features/Auth/presentation/views/verification_view.dart';
import 'package:sammly/features/Auth/presentation/widgets/custom_text_field.dart';
import 'package:sammly/generated/l10n.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); // عشان نقفل الكيبورد زي ما اتعلمنا
      },
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is SendResetCodeSuccessState) {
            // Navigate to verification screen with the email
            final authCubit = context.read<AuthCubit>();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: authCubit,
                  child: VerificationView(email: _emailController.text.trim()),
                ),
              ),
            );
          } else if (state is SendResetCodeFailedState) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
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
              icon: Icon(Icons.arrow_back_ios_new, color: AppColors.blackColor),
              onPressed: () {
                Navigator.pop(context);
              },
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

                  // 1. اللوجو
                  // 💡 ملحوظة: لو اللوجو بتاعك لونه أبيض، هتحتاج تجيب اللوجو الملون من فيجما
                  // وتحفظه باسم جديد مثلاً AppImages.logoColored عشان يظهر على الخلفية البيضاء
                  SvgPicture.asset(
                    AppImages.splash,
                    width: 160.w,
                    height: 147.h,
                  ),
                  SizedBox(height: 32.h),

                  // 2. مؤشر الخطوات (Progress Indicator)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (index) {
                      return Container(
                        width: 30.w,
                        height: 4.h,
                        margin: EdgeInsets.symmetric(horizontal: 4.w),
                        decoration: BoxDecoration(
                          // الخطوة الأولى لونها أزرق/أخضر، والباقي رمادي فاتح
                          color: index == 0
                              ? AppColors.primaryColor
                              : AppColors
                                    .bg2Color, // استخدمنا لون الخلفية الفاتح بتاعك
                          borderRadius: BorderRadius.circular(2.r),
                        ),
                      );
                    }),
                  ),
                  SizedBox(height: 40.h),

                  // 3. العناوين
                  Text(
                    S.of(context).forgotPasswordTitle,
                    style: AppTextStyles.heading28ExtraBold,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    S.of(context).forgotPasswordDesc,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.body14Regular.copyWith(
                      color: Colors.grey[600],
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 32.h),

                  // 4. حقل الإيميل
                  CustomTextField(
                    controller: _emailController,
                    thing: S.of(context).enterYourEmailHint,
                    preffixicon: Icons.email_outlined,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return S.of(context).pleaseEnterYourEmail;
                      }

                      if (!value.contains('@') || !value.contains('.')) {
                        return S.of(context).pleaseEnterValidEmail;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 32.h),

                  // 5. زرار المتابعة
                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      if (state is SendResetCodeLoadingState) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return CustomButton(
                        text: S.of(context).next,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<AuthCubit>().sendPasswordResetCode(
                              email: _emailController.text.trim(),
                            );
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
