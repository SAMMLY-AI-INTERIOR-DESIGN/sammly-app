import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/widgets/custom_appbar.dart';
import 'package:sammly/core/widgets/custombutton.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sammly/features/Auth/cubit/auth_cubit.dart';
import 'package:sammly/features/Auth/cubit/auth_states.dart';
import 'package:sammly/features/Auth/presentation/widgets/custom_text_field.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: const CustomAppbar(title: 'Change Password'),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 32.h),
              CustomTextField(
                controller: _oldPasswordController,
                thing: 'Enter your old password',
                preffixicon: Icons.lock,
                ispassword: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your old password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 24.h),
              CustomTextField(
                controller: _newPasswordController,
                thing: 'Enter your new password',
                preffixicon: Icons.lock,
                ispassword: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your new password';
                  } else if (value.length < 8) {
                    return 'Password must be at least 8 characters';
                  }
                  return null;
                },
              ),
              SizedBox(height: 24.h),
              CustomTextField(
                controller: _confirmPasswordController,
                thing: 'Confirm your new password',
                preffixicon: Icons.lock,
                ispassword: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your new password';
                  } else if (value != _newPasswordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              SizedBox(height: 48.h),
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is ChangePasswordSuccessState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Password changed successfully'),
                        backgroundColor: Colors.green,
                      ),
                    );
                    Navigator.pop(context);
                  } else if (state is ChangePasswordFailedState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.errorMsg),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is ChangePasswordLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return CustomButton(
                    text: 'Submit',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthCubit>().changePassword(
                          oldPassword: _oldPasswordController.text,
                          newPassword: _newPasswordController.text,
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
    );
  }
}
