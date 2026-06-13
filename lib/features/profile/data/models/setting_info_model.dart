class SettingInfoModel {
  final String? avatar;
  final String? name;
  final String? username;
  final String? joinedAt;
  final bool? hasUnreadNotifications;

  SettingInfoModel({
    this.avatar,
    this.name,
    this.username,
    this.joinedAt,
    this.hasUnreadNotifications,
  });

  factory SettingInfoModel.fromJson(Map<String, dynamic> json) {
    return SettingInfoModel(
      avatar: json['avatar']?.toString(),
      name: json['name']?.toString(),
      username: json['username']?.toString(),
      joinedAt: json['joinedAt']?.toString(),
      hasUnreadNotifications: json['hasUnreadNotifications'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (avatar != null) 'avatar': avatar,
      if (name != null) 'name': name,
      if (username != null) 'username': username,
      if (joinedAt != null) 'joinedAt': joinedAt,
      if (hasUnreadNotifications != null)
        'hasUnreadNotifications': hasUnreadNotifications,
    };
  }
}
