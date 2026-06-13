import 'package:sammly/features/notifications/data/model/notifications_model.dart';

abstract class NotificationsState {}

class NotificationsInitial extends NotificationsState {}

class GetNotificationsLoading extends NotificationsState {}

class GetNotificationsSuccess extends NotificationsState {
  final NotificationsResponse response;
  GetNotificationsSuccess(this.response);
}

class GetNotificationsFailure extends NotificationsState {
  final String error;
  GetNotificationsFailure(this.error);
}
