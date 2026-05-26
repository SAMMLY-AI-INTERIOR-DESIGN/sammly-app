import 'package:flutter/material.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/constant/app_strings.dart';
import 'package:sammly/core/widgets/custom_appbar.dart';
import 'package:sammly/features/profile/presentation/views/widgets/notifications_list_view.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: const CustomAppbar(title: AppStrings.notification),
      body: SafeArea(
        child: NotificationsListView(),
      ),
    );
  }
}

// NoDataWidget(
//   image: AppImages.noNotifications,
//   title: AppStrings.noNotifications,
//   description: AppStrings.noNotificationsDesc,
// )