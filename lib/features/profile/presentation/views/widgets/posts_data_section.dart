import 'package:flutter/material.dart';
import 'package:sammly/core/constant/app_strings.dart';
import 'package:sammly/core/theme/text_styles.dart';

class PostsDataSection extends StatelessWidget {
  const PostsDataSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(AppStrings.sharedImages, style: AppTextStyles.title18SemiBold);
  }
}
