import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sammly/core/theme/text_styles.dart';
import 'package:sammly/core/widgets/custom_heart_item.dart';

class ProfileDataSection extends StatelessWidget {
  const ProfileDataSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 12.h),
        Text("Fatma Salah", style: AppTextStyles.title20Bold),
        SizedBox(height: 8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("23 post", style: AppTextStyles.body14Regular),
            SizedBox(width: 24.w),
            Row(
              children: [
                CustomHeartItem(),
                SizedBox(width: 4.w),
                Text("120", style: AppTextStyles.body14Regular),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
