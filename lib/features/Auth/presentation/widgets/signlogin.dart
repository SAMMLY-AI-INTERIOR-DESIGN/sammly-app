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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // النص الأول العادي (باللون الأسود/الرمادي)
        Text(
          text1,
          style: AppTextStyles.body14Regular.copyWith(
            color: AppColors.blackColor,
          ),
        ),
        const SizedBox(width: 4), // مسافة صغيرة بين الكلمتين
        // النص التاني (اللي هيكون Colorful ولما تدوس عليه يشتغل)
        GestureDetector(
          onTap: ontap,
          child: ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [
                Color.fromARGB(255, 37, 153, 114),
                AppColors.primaryColor, // الأزرق
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ).createShader(bounds),
            child: Text(
              text2,
              style: AppTextStyles.body14Regular.copyWith(
                color: Colors.white, // لازم أبيض عشان الـ Shader يلونها
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
