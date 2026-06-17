import 'package:sammly/features/Explore/data/design_details_model.dart';

class PublicProfileModel {
  final ProfileData profile;
  final bool isFollowing;
  final ProfileStats stats;
  final PaginationData pagination;
  final List<DesignDetailsModel> designs;

  PublicProfileModel({
    required this.profile,
    required this.isFollowing,
    required this.stats,
    required this.pagination,
    required this.designs,
  });

  factory PublicProfileModel.fromJson(Map<String, dynamic> json) {
    return PublicProfileModel(
      profile: ProfileData.fromJson(json['profile'] ?? {}),
      isFollowing: json['isFollowing'] ?? false,
      stats: ProfileStats.fromJson(json['stats'] ?? {}),
      pagination: PaginationData.fromJson(json['pagination'] ?? {}),
      designs: (json['designs'] as List?)
              ?.map((e) => DesignDetailsModel.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class ProfileData {
  final String userId;
  final String name;
  final String avatar;

  ProfileData({required this.userId, required this.name, required this.avatar});

  factory ProfileData.fromJson(Map<String, dynamic> json) {
    return ProfileData(
      userId: json['userId'] ?? '',
      name: json['name'] ?? '',
      avatar: json['avatar'] ?? '',
    );
  }
}

class ProfileStats {
  final int totalDesigns;
  final int totalLikes;

  ProfileStats({required this.totalDesigns, required this.totalLikes});

  factory ProfileStats.fromJson(Map<String, dynamic> json) {
    return ProfileStats(
      totalDesigns: json['totalDesigns'] ?? 0,
      totalLikes: json['totalLikes'] ?? 0,
    );
  }
}

class PaginationData {
  final int page;
  final int limit;
  final bool hasMore;

  PaginationData({required this.page, required this.limit, required this.hasMore});

  factory PaginationData.fromJson(Map<String, dynamic> json) {
    return PaginationData(
      page: json['page'] ?? 1,
      limit: json['limit'] ?? 20,
      hasMore: json['hasMore'] ?? false,
    );
  }
}
