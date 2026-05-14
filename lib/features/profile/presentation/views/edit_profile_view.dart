import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/constant/app_images.dart';
import 'package:sammly/core/constant/app_strings.dart';
import 'package:sammly/core/theme/text_styles.dart';
import 'package:sammly/core/widgets/custom_appbar.dart';
import 'package:sammly/core/widgets/custombutton.dart';
import 'package:sammly/features/profile/presentation/views/widgets/custom_drop_town.dart';
import 'package:sammly/features/profile/presentation/views/widgets/custom_text_field.dart';
import 'package:sammly/features/profile/presentation/views/widgets/edit_image_section.dart';


class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor, 
      appBar: const CustomAppbar(title: AppStrings.editProfile),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: Column(
          children: [
            EditImageSection(),
            
            SizedBox(height: 20.h),

            CustomTextField(label: AppStrings.fullName, initialValue: "Fatma Salah"),
            CustomTextField(label: AppStrings.userName, initialValue: "FatmaSalah"),
            
            CustomTextField(
              label: AppStrings.dateOfBirth, 
              initialValue: "11 July 2004", 
              suffixIcon: SvgPicture.asset(AppImages.caledar, width: 20.w, height: 20.h),
            ),

            CustomTextField(
              label: AppStrings.phoneNumber,
              initialValue: "123-456-7890",
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

            Row(
              children: [
                Expanded(
                  child: CustomDropdown(label: AppStrings.country, value: "United States"),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: CustomDropdown(label: AppStrings.gender, value: "male"),
                ),
              ],
            ),

            SizedBox(height: 30.h),

            CustomButton(
              text: AppStrings.update,
              onPressed: () {
              },
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  
}