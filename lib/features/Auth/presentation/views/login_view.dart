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
import 'package:sammly/features/Auth/presentation/views/forgot_password_view.dart';
import 'package:sammly/features/Auth/presentation/views/signup_view.dart';
import 'package:sammly/features/support/presentation/views/support_view.dart';
import 'package:sammly/features/support/cubit/support_cubit.dart';
import 'package:sammly/features/support/data/repo/support_repo.dart';
import 'package:sammly/features/Auth/presentation/views/verfictionofsign.dart';
import 'package:sammly/features/Auth/presentation/widgets/custom_line.dart';
import 'package:sammly/features/Auth/presentation/widgets/custom_text_field.dart';
import 'package:sammly/features/Auth/presentation/widgets/loginwith.dart';
import 'package:sammly/features/Auth/presentation/widgets/signlogin.dart';
import 'package:sammly/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:sammly/features/home/logic/home_cubit.dart';
import 'package:sammly/generated/l10n.dart';
import 'package:sammly/core/localization/locale_cubit.dart';

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
    // 💡 التريكة الجديدة: غلفنا الشاشة بـ GestureDetector
    return GestureDetector(
      onTap: () {
        // السطر ده بيلغي الـ Focus من حقل الإدخال فبالتالي الكيبورد بتنزل
        FocusScope.of(context).unfocus();
      },
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            // Fetch fresh profile, settings & home data for the new account
            context.read<ProfileCubit>().fetchProfile(forceRefresh: true);
            context.read<ProfileCubit>().fetchSettingInfo();
            context.read<HomeCubit>().fetchHomeData();
            Navigator.pushReplacementNamed(context, AppRoutes.layoutView);
          } else if (state is AuthNeedsVerificationState) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(
                    state.message ?? S.of(context).pleaseVerifyEmail,
                  ),
                  backgroundColor: Colors.orange,
                ),
              );

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: context.read<AuthCubit>(),
                  child: SignUpVerificationView(
                    email: state.email,
                    isFromLogin: true,
                  ),
                ),
              ),
            );
          } else if (state is LoginFailedState) {
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
        child: PopScope(
          canPop: false,
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
                      colors: [
                        AppColors.primaryColor,
                        AppColors.secondaryColor,
                      ],
                    ),
                  ),
                ),

                // Language Switcher
                Positioned(
                  top: 24.h,
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

                // 2. Logo
                PositionedDirectional(
                  top: 0,
                  start: 0,
                  end: 0,
                  height: 309.h,
                  child: SafeArea(
                    bottom: false,
                    child: Center(
                      child: SvgPicture.asset(
                        AppImages.splash,
                        width: 345.04.w,
                        fit: BoxFit.contain,
                        colorFilter: const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ),

                // 3. Form card
                PositionedDirectional(
                  top: 280.h,
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
                              S.of(context).welcomeBack,
                              style: AppTextStyles.heading28ExtraBold,
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              S.of(context).loginToAccount,
                              style: AppTextStyles.body16Regular,
                            ),
                            SizedBox(height: 32.h),

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

                            CustomTextField(
                              controller: _passwordController,
                              thing: S.of(context).enterYourPasswordHint,
                              preffixicon: Icons.lock_outline,
                              ispassword: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return S.of(context).pleaseEnterYourPassword;
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 2.h),

                            Align(
                              alignment: AlignmentDirectional.centerEnd,
                              child: TextButton(
                                onPressed: () {
                                  final authCubit = context.read<AuthCubit>();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => BlocProvider.value(
                                        value: authCubit,
                                        child: const ForgotPasswordScreen(),
                                      ),
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
                                  S.of(context).forgotPassword,
                                  style: AppTextStyles.body14Regular,
                                ),
                              ),
                            ),
                            SizedBox(height: 24.h),

                            BlocBuilder<AuthCubit, AuthState>(
                              builder: (context, state) {
                                if (state is LoginLoadingState) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                return CustomButton(
                                  text: S.of(context).logIn,
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      context.read<AuthCubit>().login(
                                        email: _emailController.text.trim(),
                                        password: _passwordController.text,
                                      );
                                    }
                                  },
                                );
                              },
                            ),
                            SizedBox(height: 24.h),

                            Customline(text: S.of(context).orLoginWith),
                            SizedBox(height: 24.h),

                            Loginwith(
                              onGoogleTap: () {},
                              onFacebookTap: () {},
                              onAppleTap: () {},
                            ),
                            SizedBox(height: 32.h),

                            SignLogin(
                              text1: S.of(context).dontHaveAccount,
                              text2: S.of(context).signUp,
                              ontap: () {
                                final authCubit = context.read<AuthCubit>();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => BlocProvider.value(
                                      value: authCubit,
                                      child: const SignUpScreen(),
                                    ),
                                  ),
                                );
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
      ),
    );
  }
}
