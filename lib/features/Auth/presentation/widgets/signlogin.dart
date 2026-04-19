import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/theme/text_styles.dart';

class SignLogin extends StatelessWidget {
  const SignLogin({
    super.key,
    required this.text1,
    required this.text2,
    required this.ontap,
  });
  
  final String text1;
  final String text2;
  final VoidCallback ontap;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        style: AppTextStyles.body14Regular.copyWith(color: AppColors.blackColor),
        children: [
          TextSpan(text: text1),
          TextSpan(
            text: " $text2",
            style: AppTextStyles.body14Regular.copyWith(
              color: AppColors.secondaryColor,
              fontWeight: FontWeight.bold,
            ),
            recognizer: TapGestureRecognizer()..onTap = ontap,
          ),
        ],
      ),
    );
  }
}