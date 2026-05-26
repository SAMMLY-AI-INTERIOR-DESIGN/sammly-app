import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/theme/text_styles.dart';
import 'package:sammly/core/widgets/custombutton.dart';
import 'package:sammly/features/support/cubit/support_cubit.dart';
import 'package:sammly/features/support/cubit/support_states.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _selectedSubject;
  final List<String> _subjects = [
    'Account Problem',
    'Bug Report',
    'Feature Request',
    'Login Issue',
    'Report User',
    'Registration Problem',
    'Verification Code',
    'Password Reset',
    'Technical Support',
    'Other',
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
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Support request sent successfully!'),
                backgroundColor: AppColors.secondaryColor,
              ),
            );
            Navigator.pop(context);
          } else if (state is SendSupportFailedState) {
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
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              'Support',
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
                    'Have a question or need assistance?',
                    style: AppTextStyles.body16Regular.copyWith(
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Reach out to us via email.',
                    style: AppTextStyles.body14Regular.copyWith(
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "We're eager to assist you.",
                    style: AppTextStyles.body14Regular.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                  SizedBox(height: 32.h),

                  // حقل الإيميل
                  Text(
                    'Email',
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
                          hintText: 'Enter your email',
                          hintStyle: AppTextStyles.hint12Light.copyWith(
                            fontSize: 14.sp,
                          ),
                        ),
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
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // حقل الموضوع (Dropdown)
                  Text(
                    'Subject',
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
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                    padding: EdgeInsets.all(1.w),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                      child: DropdownButtonFormField<String>(
                        initialValue: _selectedSubject,
                        dropdownColor: AppColors.whiteColor,
                        hint: Text(
                          'Select Subject',
                          style: AppTextStyles.hint12Light.copyWith(
                            fontSize: 14.sp,
                          ),
                        ),
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: AppColors.primaryColor,
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
                        ),
                        isExpanded: true,
                        selectedItemBuilder: (BuildContext context) {
                          return _subjects.map((String subject) {
                            return Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                subject,
                                style: AppTextStyles.body14Regular.copyWith(
                                  color: AppColors.blackColor,
                                ),
                              ),
                            );
                          }).toList();
                        },
                        items: _subjects.map((String subject) {
                          final isLast = subject == _subjects.last;
                          return DropdownMenuItem<String>(
                            value: subject,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10.h),
                                  child: Text(
                                    subject,
                                    style: AppTextStyles.body14Regular.copyWith(
                                      color: AppColors.blackColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                if (!isLast)
                                  Container(
                                    height: 1,
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.transparent,
                                          AppColors.primaryColor,
                                          AppColors.secondaryColor,
                                          Colors.transparent,
                                        ],
                                        stops: [0.0, 0.3, 0.7, 1.0],
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            _selectedSubject = newValue;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a subject';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // حقل الرسالة
                  Text(
                    'Message:',
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
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
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
                          hintText: 'Enter your message',
                          hintStyle: AppTextStyles.hint12Light.copyWith(
                            fontSize: 14.sp,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your message';
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
                        text: 'Submit',
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<SupportCubit>().sendSupportRequest(
                              email: _emailController.text.trim(),
                              subject: _selectedSubject!.toLowerCase(),
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
