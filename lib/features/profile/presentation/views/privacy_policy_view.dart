import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/constant/app_strings.dart';
import 'package:sammly/core/theme/text_styles.dart';
import 'package:sammly/core/widgets/custom_appbar.dart';

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: AppStrings.privacyPolicy),
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(32.w),
          child: SingleChildScrollView(
            child: Text(
              ''' 
We respect your privacy and are committed to protecting your personal information.

Our app may collect limited information such as your email address, user inputs (prompts), and images generated within the app. 

This information is used only to improve the user experience and provide better services.

We do not sell, trade, or share your personal information with third parties.

All data is handled securely and used only for the purpose of operating and improving the application.

By using this app, you agree to the collection and use of information in accordance with this privacy policy.
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
