import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sammly/core/constant/app_strings.dart';
import 'package:sammly/core/theme/text_styles.dart';
import 'package:sammly/core/widgets/custom_heart_item.dart';

class PostsDataSection extends StatelessWidget {
  const PostsDataSection({super.key, required this.postsCount, required this.likesCount});
  final String postsCount;
  final String likesCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(AppStrings.sharedImages, style: AppTextStyles.title18SemiBold),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("$postsCount post", style: AppTextStyles.body14Regular),
            SizedBox(width: 24.w),
            Row(
              children: [
                const CustomHeartItem(),
                SizedBox(width: 4.w),
                Text(likesCount, style: AppTextStyles.body14Regular),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
