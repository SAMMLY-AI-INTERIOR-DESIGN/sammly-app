import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sammly/core/constant/app_strings.dart';
import 'package:sammly/core/theme/text_styles.dart';
import 'package:sammly/core/widgets/custom_heart_item.dart';

class PostsDataSection extends StatelessWidget {
  const PostsDataSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(AppStrings.sharedImages, style: AppTextStyles.title18SemiBold),
        const Spacer(),
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
