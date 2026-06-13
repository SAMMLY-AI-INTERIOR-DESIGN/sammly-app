import 'package:flutter/material.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/constant/app_strings.dart';
import 'package:sammly/core/widgets/custom_appbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sammly/features/notifications/cubit/notifications_cubit.dart';
import 'package:sammly/features/notifications/data/repo/notifications_repo.dart';
import 'package:sammly/features/notifications/presentation/widgets/notifications_list_view.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: const CustomAppbar(title: AppStrings.notification),
      body: SafeArea(
        child: BlocProvider(
          create: (context) => NotificationsCubit(NotificationsRepo()),
          child: const NotificationsListView(),
        ),
      ),
    );
  }
}

// NoDataWidget(
//   image: AppImages.noNotifications,
//   title: AppStrings.noNotifications,
//   description: AppStrings.noNotificationsDesc,
// )