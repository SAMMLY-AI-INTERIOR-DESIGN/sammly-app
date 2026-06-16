import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:sammly/core/routing/routes.dart';
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
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sammly/core/constant/app_images.dart';
import 'package:sammly/generated/l10n.dart';
import 'package:sammly/core/localization/locale_cubit.dart';

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
    // غلفنا الشاشة بـ GestureDetector لقفل الكيبورد
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            final authCubit = context.read<AuthCubit>();
            Navigator.push(
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
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(S.of(context).registrationSuccessVerifyEmail),
                  backgroundColor: Colors.green,
                ),
              );
          } else if (state is AuthNeedsVerificationState) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(
                    state.message ?? 'Please verify your email to continue.',
                  ),
                  backgroundColor: Colors.orange,
                ),
              );
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: context.read<AuthCubit>(),
                  child: SignUpVerificationView(email: state.email),
                ),
              ),
            );
          } else if (state is RegisterFailedState) {
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
          resizeToAvoidBottomInset: false,
          backgroundColor: AppColors.whiteColor,
          body: Stack(
            children: [
              // 1. Background gradient (full screen)
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.center,
                    colors: [AppColors.primaryColor, AppColors.secondaryColor],
                  ),
                ),
              ),

              // Language Switcher
              Positioned(
                top: 50.h,
                right: 24.w,
                child: SafeArea(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      context.read<LocaleCubit>().toggleLanguage();
                    },
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            AppImages.languageIcon,
                            colorFilter: const ColorFilter.mode(
                              Colors.white,
                              BlendMode.srcIn,
                            ),
                            width: 24.w,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            context.watch<LocaleCubit>().state.languageCode ==
                                    'en'
                                ? 'العربية'
                                : 'English',
                            style: AppTextStyles.body16SemiBold.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // 2. Form card
              PositionedDirectional(
                top: 134.h,
                start: 0,
                end: 0,
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
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
                    padding: EdgeInsetsDirectional.only(
                      start: 24.w,
                      end: 24.w,
                      top: 32.h,
                      bottom: 24.h + MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            S.of(context).signUpTitle,
                            style: AppTextStyles.heading28ExtraBold,
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            S.of(context).createNewAccount,
                            style: AppTextStyles.body16Regular,
                          ),
                          SizedBox(height: 32.h),

                          // حقل الاسم
                          CustomTextField(
                            controller: _nameController,
                            thing: S.of(context).enterYourName,
                            preffixicon: Icons.person_outline,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return S.of(context).pleaseEnterYourName;
                              }
                              return null;
                            },
                          ),

                          // حقل الإيميل
                          CustomTextField(
                            controller: _emailController,
                            thing: S.of(context).enterYourEmailHint,
                            preffixicon: Icons.email_outlined,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return S.of(context).pleaseEnterYourEmail;
                              }
                              if (!value.contains('@') ||
                                  !value.contains('.')) {
                                return S.of(context).pleaseEnterValidEmail;
                              }
                              return null;
                            },
                          ),

                          // حقل الباسورد
                          CustomTextField(
                            controller: _passwordController,
                            thing: S.of(context).enterYourPasswordHint,
                            preffixicon: Icons.lock_outline,
                            ispassword: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return S.of(context).pleaseEnterYourPassword;
                              }
                              if (value.length < 8) {
                                return S.of(context).passwordAtLeast8Chars;
                              }
                              return null;
                            },
                          ),

                          // حقل تأكيد الباسورد
                          CustomTextField(
                            controller: _confirmPasswordController,
                            thing: S.of(context).confirmPassword,
                            preffixicon: Icons.lock_outline,
                            ispassword: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return S.of(context).pleaseConfirmYourPassword;
                              }
                              if (value != _passwordController.text) {
                                return S.of(context).passwordsDoNotMatch;
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
                                    TextSpan(text: S.of(context).iAgreeToAll),
                                    TextSpan(
                                      text: S.of(context).termsConditions,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.blackColor,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.pushNamed(
                                            context,
                                            AppRoutes.termsView,
                                          );
                                        },
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
                                text: S.of(context).signUp,
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    if (!_isTermsAccepted) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            S.of(context).pleaseAcceptTerms,
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

                          Customline(text: S.of(context).orSignupWith),
                          SizedBox(height: 24.h),

                          Loginwith(
                            onGoogleTap: () {},
                            onFacebookTap: () {},
                            onAppleTap: () {},
                          ),
                          SizedBox(height: 32.h),

                          SignLogin(
                            text1: S.of(context).alreadyHaveAccount,
                            text2: S.of(context).logIn,
                            ontap: () {
                              // الرجوع لشاشة اللوجين
                              Navigator.pop(context);
                            },
                          ),
                          SizedBox(height: 20.h),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => BlocProvider(
                                    create: (context) =>
                                        SupportCubit(SupportRepo()),
                                    child: const SupportScreen(),
                                  ),
                                ),
                              );
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text(
                              S.of(context).supportQuestion,
                              style: AppTextStyles.body14Regular.copyWith(
                                color: AppColors.blackColor,
                              ),
                              textAlign: TextAlign.center,
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
    );
  }
}
