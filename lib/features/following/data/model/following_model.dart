class FollowingModel {
  final String id;
  final String name;
  final String? avatar;

  FollowingModel({
    required this.id,
    required this.name,
    this.avatar,
  });

  factory FollowingModel.fromJson(Map<String, dynamic> json) {
    return FollowingModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      avatar: json['avatar'],
    );
  }
}

class FollowingResponse {
  final int page;
  final int limit;
  final bool hasMore;
  final List<FollowingModel> profiles;

  FollowingResponse({
    required this.page,
    required this.limit,
    required this.hasMore,
    required this.profiles,
  });

  factory FollowingResponse.fromJson(Map<String, dynamic> json) {
    final pagination = json['pagination'] ?? {};
    final profilesList = json['profiles'] as List? ?? [];
    return FollowingResponse(
      page: pagination['page'] ?? 1,
      limit: pagination['limit'] ?? 20,
      hasMore: pagination['hasMore'] ?? false,
      profiles: profilesList.map((e) => FollowingModel.fromJson(e)).toList(),
    );
  }
}
