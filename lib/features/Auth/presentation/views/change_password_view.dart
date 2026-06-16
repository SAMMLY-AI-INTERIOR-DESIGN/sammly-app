import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/widgets/custom_appbar.dart';
import 'package:sammly/core/widgets/custombutton.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sammly/features/Auth/cubit/auth_cubit.dart';
import 'package:sammly/features/Auth/cubit/auth_states.dart';
import 'package:sammly/features/Auth/presentation/widgets/custom_text_field.dart';
import 'package:sammly/generated/l10n.dart';

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
      appBar: CustomAppbar(title: S.of(context).changePassword),
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
                thing: S.of(context).currentPassword,
                preffixicon: Icons.lock,
                ispassword: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return S.of(context).pleaseEnterYourOldPassword;
                  }
                  return null;
                },
              ),
              SizedBox(height: 24.h),
              CustomTextField(
                controller: _newPasswordController,
                thing: S.of(context).newPassword,
                preffixicon: Icons.lock,
                ispassword: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return S.of(context).pleaseEnterYourNewPassword;
                  } else if (value.length < 8) {
                    return S.of(context).passwordAtLeast8Chars;
                  }
                  return null;
                },
              ),
              SizedBox(height: 24.h),
              CustomTextField(
                controller: _confirmPasswordController,
                thing: S.of(context).confirmNewPassword,
                preffixicon: Icons.lock,
                ispassword: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return S.of(context).pleaseConfirmYourNewPassword;
                  } else if (value != _newPasswordController.text) {
                    return S.of(context).passwordsDoNotMatch;
                  }
                  return null;
                },
              ),
              SizedBox(height: 48.h),
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is ChangePasswordSuccessState) {
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        SnackBar(
                          content: Text(S.of(context).passwordChangedSuccess),
                          backgroundColor: Colors.green,
                        ),
                      );
                    Navigator.pop(context);
                  } else if (state is ChangePasswordFailedState) {
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
                builder: (context, state) {
                  if (state is ChangePasswordLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return CustomButton(
                    text: S.of(context).submit,
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
