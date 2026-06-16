import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sammly/core/theme/text_styles.dart';
import 'package:sammly/core/widgets/custom_heart_item.dart';
import 'package:sammly/generated/l10n.dart';

class PostsDataSection extends StatelessWidget {
  const PostsDataSection({
    super.key,
    required this.postsCount,
    required this.likesCount,
  });
  final String postsCount;
  final String likesCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(S.of(context).sharedImages, style: AppTextStyles.title18SemiBold),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(S.of(context).postsCountLabel(int.tryParse(postsCount) ?? 0), style: AppTextStyles.body14Regular),
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
