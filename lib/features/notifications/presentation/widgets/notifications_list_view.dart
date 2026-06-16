import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sammly/core/constant/app_colors.dart';
import 'package:sammly/core/constant/app_images.dart';
import 'package:sammly/core/widgets/no_data_widget.dart';
import 'package:sammly/features/notifications/cubit/notifications_cubit.dart';
import 'package:sammly/features/notifications/cubit/notifications_states.dart';
import 'package:sammly/features/notifications/presentation/widgets/notificatios_item_widget.dart';
import 'package:sammly/generated/l10n.dart';

class NotificationsListView extends StatefulWidget {
  const NotificationsListView({super.key});

  @override
  State<NotificationsListView> createState() => _NotificationsListViewState();
}

class _NotificationsListViewState extends State<NotificationsListView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<NotificationsCubit>().getNotifications();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<NotificationsCubit>().getNotifications(loadMore: true);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationsCubit, NotificationsState>(
      builder: (context, state) {
        final cubit = context.read<NotificationsCubit>();

        if (state is GetNotificationsLoading && cubit.notifications.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (cubit.notifications.isEmpty) {
          return Column(
            children: [
              Expanded(
                child: NoDataWidget(
                  image: AppImages.noNotifications,
                  title: S.of(context).noNotifications,
                  description: S.of(context).noNotificationsDesc,
                ),
              ),
            ],
          );
        }

        return ListView.separated(
          controller: _scrollController,
          itemCount:
              cubit.notifications.length +
              (state is GetNotificationsLoading ? 1 : 0),
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
            if (index >= cubit.notifications.length) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
                ),
              );
            }
            return NotificationItemWidget(item: cubit.notifications[index]);
          },
        );
      },
    );
  }
}
