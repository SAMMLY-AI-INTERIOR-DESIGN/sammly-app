import 'package:flutter/material.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/constant/app_strings.dart';
import 'package:sammly/core/widgets/custom_appbar.dart'; 
import 'package:sammly/features/profile/presentation/views/widgets/following_list_view.dart';

class FollowingView extends StatelessWidget {
  const FollowingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor, 
      appBar: const CustomAppbar(title: AppStrings.following),
      body: SafeArea(
        child: FollowingListView(),
      ),
    );
  }
}