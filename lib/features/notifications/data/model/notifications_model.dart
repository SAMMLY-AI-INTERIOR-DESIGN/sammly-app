class NotificationItemModel {
  final String id;
  final String title;
  final String body;
  final String? type;
  final String? avatar;
  final String createdAt;

  NotificationItemModel({
    required this.id,
    required this.title,
    required this.body,
    this.type,
    this.avatar,
    required this.createdAt,
  });

  factory NotificationItemModel.fromJson(Map<String, dynamic> json) {
    return NotificationItemModel(
      id: json['_id'] ?? '',
      title: json['title'] ?? json['name'] ?? '',
      body: json['body'] ?? json['action'] ?? '',
      type: json['type'],
      avatar: json['avatar'] ?? json['imageUrl'],
      createdAt: json['createdAt'] ?? json['time'] ?? '',
    );
  }
}

class NotificationsResponse {
  final int page;
  final int limit;
  final bool hasMore;
  final List<NotificationItemModel> notifications;

  NotificationsResponse({
    required this.page,
    required this.limit,
    required this.hasMore,
    required this.notifications,
  });

  factory NotificationsResponse.fromJson(Map<String, dynamic> json) {
    final pagination = json['pagination'] ?? {};
    final notifsList = json['notifications'] as List? ?? [];
    return NotificationsResponse(
      page: pagination['page'] ?? 1,
      limit: pagination['limit'] ?? 20,
      hasMore: pagination['hasMore'] ?? false,
      notifications: notifsList
          .map((e) => NotificationItemModel.fromJson(e))
          .toList(),
    );
  }
}
