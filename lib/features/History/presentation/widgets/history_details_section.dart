import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/theme/text_styles.dart';

class HistoryDetailsSection extends StatelessWidget {
  const HistoryDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailRow('Room : ', 'Living Room'),
        SizedBox(height: 12.h),
        _buildDetailRow('Style : ', 'Art deco'),
        SizedBox(height: 12.h),
        _buildDetailRow(
          'Prompt: ',
          'Lorem ipsum dolor sit amet consectetur. Nibh malesuada amet viverra morbi congue nascetur semper gravida. Vestibulum aliquam platea sem ornare.',
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontFamily: AppTextStyles.primaryFont,
          fontSize: 15.sp,
          color: AppColors.blackColor2,
          height: 1.5,
        ),
        children: [
          TextSpan(
            text: label,
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
          TextSpan(
            text: value,
            style: const TextStyle(fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
