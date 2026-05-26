import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/constant/app_strings.dart';
import 'package:sammly/core/theme/text_styles.dart';
import 'package:sammly/core/widgets/custom_appbar.dart';

class TermsConditionsView extends StatelessWidget {
  const TermsConditionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: AppStrings.termsConditions),
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(32.w),
          child: SingleChildScrollView(
            child: Text(
              ''' 
By accessing and using this application, you agree to follow the terms and conditions outlined below
        
Users are responsible for the content they create or share within the app.
              
Any harmful, illegal, or inappropriate use of the application is strictly prohibited.
              
The app is intended for personal and non-commercial use only.
              
We reserve the right to update or modify these terms at any time without prior notice.
              
Continued use of the application means that you accept any changes made to these terms.
''',
              style: AppTextStyles.body16Medium,
              textAlign: TextAlign.start,
            ),
          ),
        ),
      ),
    );
  }
}
