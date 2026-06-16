import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/constant/app_images.dart';
import 'package:sammly/core/widgets/custom_appbar.dart';
import 'package:sammly/core/widgets/custombutton.dart';
import 'package:sammly/features/home/logic/home_cubit.dart';
import 'package:sammly/features/profile/presentation/views/widgets/custom_drop_town.dart';
import 'package:sammly/features/profile/presentation/views/widgets/custom_text_field.dart';
import 'package:sammly/features/profile/presentation/views/widgets/edit_image_section.dart';
import 'package:sammly/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:sammly/features/profile/presentation/cubit/profile_state.dart';
import 'package:sammly/generated/l10n.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  File? _selectedImageFile;

  String selectedCountry = "🇪🇬 Egypt";
  String selectedGender = "male";
  DateTime? selectedDobDate;
  bool _fieldsPopulated = false;

  final List<String> countriesList = ["🇪🇬 Egypt", "🌐 International"];
  final List<String> gendersList = ["male", "female"];

  @override
  void initState() {
    super.initState();
    final profile = context.read<ProfileCubit>().currentProfile;
    if (profile != null) {
      _populateFields(profile);
    } else {
      // Profile not loaded yet — fetch it
      context.read<ProfileCubit>().fetchProfile(forceRefresh: true);
    }
  }

  /// Populates form fields from ProfileModel (called once).
  void _populateFields(profile) {
    if (_fieldsPopulated) return;
    _fieldsPopulated = true;

    nameController.text = profile.name ?? '';
    usernameController.text = profile.username ?? '';

    if (profile.country != null) {
      final lowerCountry = profile.country!.toLowerCase();
      if (lowerCountry.contains('egypt')) {
        selectedCountry = "🇪🇬 Egypt";
      } else if (lowerCountry.contains('international') ||
          lowerCountry.contains('usa')) {
        selectedCountry = "🌐 International";
      }
    }
    if (profile.gender != null && gendersList.contains(profile.gender)) {
      selectedGender = profile.gender!;
    }

    if (profile.dateOfBirth != null) {
      final parsedDate = DateTime.tryParse(profile.dateOfBirth!);
      if (parsedDate != null) {
        selectedDobDate = parsedDate;
        dobController.text =
            "${parsedDate.day.toString().padLeft(2, '0')}/${parsedDate.month.toString().padLeft(2, '0')}/${parsedDate.year}";
      } else {
        dobController.text = profile.dateOfBirth!;
      }
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    usernameController.dispose();
    dobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        // When profile data arrives, populate the form fields
        if (state is ProfileLoaded && !_fieldsPopulated) {
          setState(() {
            _populateFields(state.profile);
          });
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: CustomAppbar(title: S.of(context).editProfile),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          child: Column(
            children: [
              EditImageSection(
                currentAvatarUrl: context
                    .read<ProfileCubit>()
                    .currentProfile
                    ?.avatar,
                onImagePicked: (file) {
                  _selectedImageFile = file;
                },
              ),

              SizedBox(height: 20.h),

              CustomTextField(
                label: S.of(context).fullName,
                controller: nameController,
              ),
              CustomTextField(
                label: S.of(context).userName,
                controller: usernameController,
              ),

              CustomTextField(
                label: S.of(context).dateOfBirth,
                controller: dobController,
                readOnly: true,
                onTap: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: selectedDobDate ?? DateTime(2000),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null) {
                    setState(() {
                      selectedDobDate = picked;
                      dobController.text =
                          "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
                    });
                  }
                },
                suffixIcon: SvgPicture.asset(
                  AppImages.caledar,
                  width: 20.w,
                  height: 20.h,
                ),
              ),

              // التعديل الأساسي هنا
              Row(
                children: [
                  Expanded(
                    child: CustomDropdown(
                      label: S.of(context).country,
                      value: selectedCountry,
                      items: countriesList,
                      onChanged: (val) {
                        if (val != null) {
                          setState(() {
                            selectedCountry = val;
                          });
                        }
                      },
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: CustomDropdown(
                      label: S.of(context).gender,
                      value: selectedGender,
                      items: gendersList,
                      onChanged: (val) {
                        if (val != null) {
                          setState(() {
                            selectedGender = val;
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),

              SizedBox(height: 30.h),

              BlocConsumer<ProfileCubit, ProfileState>(
                listener: (context, state) {
                  if (state is EditProfileSuccess) {
                    // نعمل refresh من الـ API عشان نجيب الـ avatar URL الجديد من السيرفر
                    context.read<ProfileCubit>().fetchProfile(
                      forceRefresh: true,
                    );
                    context.read<ProfileCubit>().fetchSettingInfo();
                    context.read<HomeCubit>().fetchHomeData();
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        SnackBar(
                          content: Text(S.of(context).profileUpdatedSuccess),
                        ),
                      );
                    Navigator.pop(context);
                  } else if (state is EditProfileError) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.message)));
                  }
                },
                builder: (context, state) {
                  if (state is EditProfileLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return CustomButton(
                    text: S.of(context).update,
                    onPressed: () {
                      String? apiDob;
                      if (selectedDobDate != null) {
                        apiDob =
                            "${selectedDobDate!.year}-${selectedDobDate!.month.toString().padLeft(2, '0')}-${selectedDobDate!.day.toString().padLeft(2, '0')}";
                      } else if (dobController.text.isNotEmpty) {
                        final parts = dobController.text.split('/');
                        if (parts.length == 3) {
                          final d = int.tryParse(parts[0]);
                          final m = int.tryParse(parts[1]);
                          final y = int.tryParse(parts[2]);
                          if (d != null && m != null && y != null) {
                            apiDob =
                                "$y-${m.toString().padLeft(2, '0')}-${d.toString().padLeft(2, '0')}";
                          }
                        }
                        apiDob ??= dobController.text;
                      }

                      context.read<ProfileCubit>().editProfile({
                        "name": nameController.text,
                        "username": usernameController.text,
                        "country": selectedCountry == "🇪🇬 Egypt"
                            ? "egypt"
                            : "international",
                        "gender": selectedGender,
                        "dateOfBirth": apiDob,
                      }, imageFile: _selectedImageFile);
                    },
                  );
                },
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
