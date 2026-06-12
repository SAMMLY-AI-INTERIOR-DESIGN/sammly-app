import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/constant/app_images.dart';
import 'package:sammly/core/constant/app_strings.dart';
import 'package:sammly/core/theme/text_styles.dart';
import 'package:sammly/core/widgets/custom_appbar.dart';
import 'package:sammly/core/widgets/custombutton.dart';
import 'package:sammly/features/home/logic/home_cubit.dart';
import 'package:sammly/features/profile/presentation/views/widgets/custom_drop_town.dart';
import 'package:sammly/features/profile/presentation/views/widgets/custom_text_field.dart';
import 'package:sammly/features/profile/presentation/views/widgets/edit_image_section.dart';
import 'package:sammly/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:sammly/features/profile/presentation/cubit/profile_state.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  File? _selectedImageFile;
  
  String selectedCountry = "usa";
  String selectedGender = "male";

  final List<String> countriesList = [
  "usa",
  "egypt",
];
  final List<String> gendersList = ["male", "female"];

  @override
  void initState() {
    super.initState();
    final profile = context.read<ProfileCubit>().currentProfile;
    if (profile != null) {
      nameController.text = profile.name ?? '';
      usernameController.text = profile.username ?? '';
      dobController.text = profile.dateOfBirth ?? '';
      
      if (profile.country != null && countriesList.contains(profile.country)) {
        selectedCountry = profile.country!;
      }
      if (profile.gender != null && gendersList.contains(profile.gender)) {
        selectedGender = profile.gender!;
      }
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    usernameController.dispose();
    dobController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor, 
      appBar: const CustomAppbar(title: AppStrings.editProfile),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: Column(
          children: [
            EditImageSection(
              onImagePicked: (file) {
                _selectedImageFile = file;
              },
            ),
            
            SizedBox(height: 20.h),

            CustomTextField(
              label: AppStrings.fullName, 
              controller: nameController,
            ),
            CustomTextField(
              label: AppStrings.userName, 
              controller: usernameController,
            ),
            
            CustomTextField(
              label: AppStrings.dateOfBirth, 
              controller: dobController,
              suffixIcon: SvgPicture.asset(AppImages.caledar, width: 20.w, height: 20.h),
            ),

            CustomTextField(
              label: AppStrings.phoneNumber,
              controller: phoneController,
              prefix: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Row(
                      children: [
                        Text("20+", style: AppTextStyles.body14Regular),
                        Icon(Icons.keyboard_arrow_down, size: 18.sp),
                        SizedBox(width: 8.w),
                        Container(width: 1, height: 20.h, color: Colors.grey), 
                        SizedBox(width: 8.w),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // التعديل الأساسي هنا
            Row(
              children: [
                Expanded(
                  child: CustomDropdown(
                    label: AppStrings.country, 
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
                    label: AppStrings.gender, 
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
                  context.read<ProfileCubit>().fetchProfile(forceRefresh: true);
                  context.read<ProfileCubit>().fetchSettingInfo();
                  context.read<HomeCubit>().fetchHomeData();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Profile updated successfully!')),
                  );
                  Navigator.pop(context);
                } else if (state is EditProfileError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              },
              builder: (context, state) {
                if (state is EditProfileLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return CustomButton(
                  text: AppStrings.update,
                  onPressed: () {
                    context.read<ProfileCubit>().editProfile(
                      {
                        "name": nameController.text,
                        "username": usernameController.text,
                        "country": selectedCountry,
                        "gender": selectedGender,
                        "dateOfBirth": dobController.text.isNotEmpty ? dobController.text : null,
                      },
                      imageFile: _selectedImageFile,
                    );
                  },
                );
              },
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}