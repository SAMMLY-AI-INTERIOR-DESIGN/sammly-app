import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/theme/text_styles.dart';
import 'package:sammly/core/widgets/custombutton.dart';
import 'package:sammly/features/Auth/cubit/auth_cubit.dart';
import 'package:sammly/features/Auth/cubit/auth_states.dart';
import 'package:sammly/features/support/presentation/views/support_view.dart';
import 'package:sammly/features/support/cubit/support_cubit.dart';
import 'package:sammly/features/support/data/repo/support_repo.dart';
import 'package:sammly/features/Auth/presentation/views/verfictionofsign.dart';
import 'package:sammly/features/Auth/presentation/widgets/custom_line.dart';
import 'package:sammly/features/Auth/presentation/widgets/custom_text_field.dart';
import 'package:sammly/features/Auth/presentation/widgets/loginwith.dart';
import 'package:sammly/features/Auth/presentation/widgets/signlogin.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // Controllers لحفظ الداتا
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // حالة الشروط والأحكام
  bool _isTermsAccepted = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;

    // غلفنا الشاشة بـ GestureDetector لقفل الكيبورد
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            // Navigate to sign-up verification screen with the email
            final authCubit = context.read<AuthCubit>();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: authCubit,
                  child: SignUpVerificationView(
                    email: _emailController.text.trim(),
                  ),
                ),
              ),
            );
          } else if (state is AuthNeedsVerificationState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message ?? 'Please verify your email to continue.'),
                backgroundColor: Colors.orange,
              ),
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: context.read<AuthCubit>(),
                  child: SignUpVerificationView(
                    email: state.email,
                  ),
                ),
              ),
            );
          } else if (state is RegisterFailedState) {
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
          body: SingleChildScrollView(
            child: SizedBox(
              height: screenHeight,
              child: Stack(
                children: [
                  // 1. الجزء العلوي (الخلفية المتدرجة)
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

                  // 2. الكارت الأبيض والفورم
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      constraints: BoxConstraints(maxHeight: screenHeight * 0.88),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        // الجريدينت الخفيف بتاع الكارت
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [AppColors.bg1Color, AppColors.bg2Color],
                        ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(35.r),
                          topRight: Radius.circular(35.r),
                        ),
                      ),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.symmetric(
                          horizontal: 24.w,
                          vertical: 24.h,
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Sign UP',
                                style: AppTextStyles.heading28ExtraBold,
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                'Create your new account',
                                style: AppTextStyles.body16Regular,
                              ),
                              SizedBox(height: 32.h),

                              // حقل الاسم
                              CustomTextField(
                                controller: _nameController,
                                thing: 'Enter your name',
                                preffixicon: Icons.person_outline,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your name';
                                  }
                                  return null;
                                },
                              ),

                              // حقل الإيميل
                              CustomTextField(
                                controller: _emailController,
                                thing: 'Enter your email',
                                preffixicon: Icons.email_outlined,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your email';
                                  }
                                  if (!value.contains('@') || !value.contains('.')) {
                                    return 'Please enter a valid email address';
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
                                  if (value.length < 8) {
                                    return 'Password must be at least 8 characters';
                                  }
                                  return null;
                                },
                              ),

                              // حقل تأكيد الباسورد
                              CustomTextField(
                                controller: _confirmPasswordController,
                                thing: 'Confirm Password',
                                preffixicon: Icons.lock_outline,
                                ispassword: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please confirm your password';
                                  }
                                  if (value != _passwordController.text) {
                                    return 'Passwords do not match';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 16.h),

                              // الشروط والأحكام
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Checkbox(
                                    value: _isTermsAccepted,
                                    activeColor: AppColors.secondaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4.r),
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        _isTermsAccepted = value ?? false;
                                      });
                                    },
                                  ),
                                  Text.rich(
                                    TextSpan(
                                      style: AppTextStyles.body14Regular.copyWith(
                                        fontSize: 12.sp,
                                      ),
                                      children: [
                                        const TextSpan(
                                          text: 'I agree to all the ',
                                        ),
                                        TextSpan(
                                          text: 'Terms & Conditions',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.blackColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16.h),

                              BlocBuilder<AuthCubit, AuthState>(
                                builder: (context, state) {
                                  if (state is RegisterLoadingState) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  return CustomButton(
                                    text: 'Sign up',
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        if (!_isTermsAccepted) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                'Please accept the Terms & Conditions',
                                              ),
                                              backgroundColor: Colors.red,
                                            ),
                                          );
                                          return;
                                        }
                                        context.read<AuthCubit>().register(
                                              name: _nameController.text.trim(),
                                              email: _emailController.text.trim(),
                                              password: _passwordController.text,
                                              termsAccepted: _isTermsAccepted,
                                              privacyAccepted: _isTermsAccepted,
                                            );
                                      }
                                    },
                                  );
                                },
                              ),
                              SizedBox(height: 24.h),

                              const Customline(text: 'Or Signup with'),
                              SizedBox(height: 24.h),

                              Loginwith(
                                onGoogleTap: () {},
                                onFacebookTap: () {},
                                onAppleTap: () {},
                              ),
                              SizedBox(height: 32.h),

                              SignLogin(
                                text1: "Already have an account?",
                                text2: "Log in",
                                ontap: () {
                                  // الرجوع لشاشة اللوجين
                                  Navigator.pop(context);
                                },
                              ),SizedBox(height: 20.h,),
                              TextButton( onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => BlocProvider(
                                          create: (context) => SupportCubit(SupportRepo()),
                                          child: const SupportScreen(),
                                        ),
                                      ),
                                    );
                                  },                                style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    minimumSize: Size.zero,
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  child: Text(
                                    'Have an issue?',
                                    style: AppTextStyles.body14Regular,
                                  ),
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
      ),
    );
  }
}
