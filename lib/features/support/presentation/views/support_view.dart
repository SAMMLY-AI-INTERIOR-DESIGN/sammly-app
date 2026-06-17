import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/theme/text_styles.dart';
import 'package:sammly/core/widgets/custombutton.dart';
import 'package:sammly/features/support/cubit/support_cubit.dart';
import 'package:sammly/features/support/cubit/support_states.dart';
import 'package:sammly/generated/l10n.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isDropdownOpen = false;
  String? _selectedSubject;
  List<String> get _subjects => [
    S.of(context).subjectAccountProblem,
    S.of(context).subjectBugReport,
    S.of(context).subjectFeatureRequest,
    S.of(context).subjectLoginIssue,
    S.of(context).subjectReportUser,
    S.of(context).subjectRegistrationProblem,
    S.of(context).subjectVerificationCode,
    S.of(context).subjectPasswordReset,
    S.of(context).subjectTechnicalSupport,
    S.of(context).subjectOther,
  ];

  @override
  void dispose() {
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: BlocListener<SupportCubit, SupportState>(
        listener: (context, state) {
          if (state is SendSupportSuccessState) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(S.of(context).supportRequestSuccess),
                  backgroundColor: AppColors.secondaryColor,
                ),
              );
            Navigator.pop(context);
          } else if (state is SendSupportFailedState) {
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
            title: Text(
              S.of(context).support,
              style: AppTextStyles.title20Bold.copyWith(
                color: AppColors.blackColor,
              ),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),

                  // العناوين
                  Text(
                    S.of(context).supportQuestion,
                    style: AppTextStyles.body16Regular.copyWith(
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    S.of(context).supportReachOut,
                    style: AppTextStyles.body14Regular.copyWith(
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    S.of(context).supportEagerToAssist,
                    style: AppTextStyles.body14Regular.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                  SizedBox(height: 32.h),

                  // حقل الإيميل
                  Text(
                    S.of(context).email,
                    style: AppTextStyles.body14Regular.copyWith(
                      color: AppColors.blackColor,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.r),
                      gradient: AppColors.iconGradient,
                    ),
                    padding: EdgeInsets.all(1.w),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                      child: TextFormField(
                        controller: _emailController,
                        maxLines: 1,
                        style: AppTextStyles.body14Regular.copyWith(
                          color: AppColors.blackColor,
                        ),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 18.h,
                            horizontal: 16.w,
                          ),
                          filled: true,
                          fillColor: Colors.transparent,
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          hintText: S.of(context).enterYourEmail,
                          hintStyle: AppTextStyles.hint12Light.copyWith(
                            fontSize: 14.sp,
                          ),
                        ),
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
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // حقل الموضوع (Dropdown)
                  Text(
                    S.of(context).subject,
                    style: AppTextStyles.body14Regular.copyWith(
                      color: AppColors.blackColor,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  FormField<String>(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return S.of(context).pleaseSelectSubject;
                      }
                      return null;
                    },
                    initialValue: _selectedSubject,
                    builder: (FormFieldState<String> formState) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _isDropdownOpen = !_isDropdownOpen;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                gradient: const LinearGradient(
                                  colors: [
                                    AppColors.primaryColor,
                                    AppColors.secondaryColor,
                                  ],
                                  begin: AlignmentDirectional.centerStart,
                                  end: AlignmentDirectional.centerEnd,
                                ),
                              ),
                              padding: EdgeInsets.all(1.w),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: 18.h,
                                  horizontal: 16.w,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.whiteColor,
                                  borderRadius: BorderRadius.circular(7.r),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      _selectedSubject ??
                                          S.of(context).selectSubject,
                                      style: _selectedSubject == null
                                          ? AppTextStyles.hint12Light.copyWith(
                                              fontSize: 14.sp,
                                            )
                                          : AppTextStyles.body14Regular
                                                .copyWith(
                                                  color: AppColors.blackColor,
                                                ),
                                    ),
                                    Icon(
                                      _isDropdownOpen
                                          ? Icons.arrow_drop_up
                                          : Icons.arrow_drop_down,
                                      color: AppColors.primaryColor,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          if (_isDropdownOpen) ...[
                            SizedBox(height: 8.h),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                gradient: const LinearGradient(
                                  colors: [
                                    AppColors.primaryColor,
                                    AppColors.secondaryColor,
                                  ],
                                  begin: AlignmentDirectional.centerStart,
                                  end: AlignmentDirectional.centerEnd,
                                ),
                              ),
                              padding: EdgeInsets.all(1.w),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.whiteColor,
                                  borderRadius: BorderRadius.circular(7.r),
                                ),
                                child: Column(
                                  children: _subjects.map((String subject) {
                                    final isLast = subject == _subjects.last;
                                    final isSelected =
                                        subject == _selectedSubject;
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _selectedSubject = subject;
                                          _isDropdownOpen = false;
                                          formState.didChange(subject);
                                        });
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        padding: EdgeInsets.symmetric(
                                          vertical: 12.h,
                                          horizontal: 16.w,
                                        ),
                                        decoration: BoxDecoration(
                                          border: isLast
                                              ? null
                                              : Border(
                                                  bottom: BorderSide(
                                                    color: Colors.grey.shade300,
                                                    width: 1,
                                                  ),
                                                ),
                                        ),
                                        child: Text(
                                          subject,
                                          style: AppTextStyles.body14Regular
                                              .copyWith(
                                                color: isSelected
                                                    ? AppColors.primaryColor
                                                    : AppColors.blackColor,
                                              ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ],
                          if (formState.hasError)
                            Padding(
                              padding: EdgeInsets.only(top: 8.h, left: 16.w),
                              child: Text(
                                formState.errorText!,
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                  SizedBox(height: 16.h),

                  // حقل الرسالة
                  Text(
                    S.of(context).message,
                    style: AppTextStyles.body14Regular.copyWith(
                      color: AppColors.blackColor,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.r),
                      gradient: const LinearGradient(
                        colors: [
                          AppColors.primaryColor,
                          AppColors.secondaryColor,
                        ],
                        begin: AlignmentDirectional.centerStart,
                        end: AlignmentDirectional.centerEnd,
                      ),
                    ),
                    padding: EdgeInsets.all(1.w),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                      child: TextFormField(
                        controller: _messageController,
                        maxLines: 5,
                        style: AppTextStyles.body14Regular.copyWith(
                          color: AppColors.blackColor,
                        ),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 18.h,
                            horizontal: 16.w,
                          ),
                          filled: true,
                          fillColor: Colors.transparent,
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          hintText: S.of(context).enterYourMessage,
                          hintStyle: AppTextStyles.hint12Light.copyWith(
                            fontSize: 14.sp,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return S.of(context).pleaseEnterYourMessage;
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 32.h),

                  // زرار المتابعة
                  BlocBuilder<SupportCubit, SupportState>(
                    builder: (context, state) {
                      if (state is SendSupportLoadingState) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return CustomButton(
                        text: S.of(context).submit,
                        onPressed: () {
                          String getApiSubject(String localizedSubject) {
                            if (localizedSubject ==
                                S.of(context).subjectAccountProblem) {
                              return 'account problem';
                            }
                            if (localizedSubject ==
                                S.of(context).subjectBugReport) {
                              return 'bug report';
                            }
                            if (localizedSubject ==
                                S.of(context).subjectFeatureRequest) {
                              return 'feature request';
                            }
                            if (localizedSubject ==
                                S.of(context).subjectLoginIssue) {
                              return 'login issue';
                            }
                            if (localizedSubject ==
                                S.of(context).subjectReportUser) {
                              return 'report user';
                            }
                            if (localizedSubject ==
                                S.of(context).subjectRegistrationProblem) {
                              return 'registration problem';
                            }
                            if (localizedSubject ==
                                S.of(context).subjectVerificationCode) {
                              return 'verification code';
                            }
                            if (localizedSubject ==
                                S.of(context).subjectPasswordReset) {
                              return 'password reset';
                            }
                            if (localizedSubject ==
                                S.of(context).subjectTechnicalSupport) {
                              return 'technical support';
                            }
                            if (localizedSubject ==
                                S.of(context).subjectOther) {
                              return 'other';
                            }
                            return 'other';
                          }

                          if (_formKey.currentState!.validate()) {
                            context.read<SupportCubit>().sendSupportRequest(
                              email: _emailController.text.trim(),
                              subject: getApiSubject(_selectedSubject!),
                              message: _messageController.text.trim(),
                            );
                          }
                        },
                      );
                    },
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
