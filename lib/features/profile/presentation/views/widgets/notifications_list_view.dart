import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/constant/app_strings.dart';
import 'package:sammly/features/profile/data/models/notifications_model.dart';
import 'package:sammly/features/profile/presentation/views/widgets/notificatios_item_widget.dart';

class NotificationsListView extends StatelessWidget {
  NotificationsListView({super.key});

  final List<NotificationModel> _notifications = [
    NotificationModel(name: "Alicia Rochefort", action: AppStrings.likeYourSharedDesign, time: "09.10", imageUrl: "https://i.pravatar.cc/150?img=1"),
    NotificationModel(name: "Jessica Tan", action: AppStrings.likeYourSharedDesign, time: "09.10", imageUrl: "https://i.pravatar.cc/150?img=5"),
    NotificationModel(name: "Lolita Xue", action: AppStrings.likeYourSharedDesign, time: "09.10", imageUrl: "https://i.pravatar.cc/150?img=9"),
    NotificationModel(name: "Eaj Prakk", action: AppStrings.likeYourSharedDesign, time: "09.10", imageUrl: "https://i.pravatar.cc/150?img=11"),
    NotificationModel(name: "Jason", action: AppStrings.likeYourSharedDesign, time: "09.10", imageUrl: "https://i.pravatar.cc/150?img=15"),
    NotificationModel(name: "Kimberly", action: AppStrings.likeYourSharedDesign, time: "09.10", imageUrl: "https://i.pravatar.cc/150?img=20"),
    NotificationModel(name: "Wang", action: AppStrings.likeYourSharedDesign, time: "09.10", imageUrl: "https://i.pravatar.cc/150?img=33"),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: _notifications.length,
      separatorBuilder: (context, index) {
        return Divider(
          endIndent: 16.w,
          indent: 16.w,
          height: 1,
          thickness: 1,
          color: AppColors.greyColor.withValues(alpha: 0.1), 
        );
      },
      itemBuilder: (context, index) {
        return NotificationItemWidget(item: _notifications[index]);
      },
    );
  }
}