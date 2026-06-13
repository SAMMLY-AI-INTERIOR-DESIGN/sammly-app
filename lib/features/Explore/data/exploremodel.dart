class ExploreResponse {
  final int page;
  final bool hasMore;
  final List<ExploreDesignModel> designs;

  ExploreResponse({
    required this.page,
    required this.hasMore,
    required this.designs,
  });

  factory ExploreResponse.fromJson(Map<String, dynamic> json) {
    return ExploreResponse(
      page: json['page'] ?? 1,
      hasMore: json['hasMore'] ?? false,
      designs: (json['designs'] as List<dynamic>?)
              ?.map((e) => ExploreDesignModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

class ExploreDesignModel {
  final String id;
  final String name;
  final String avatar;
  final int likesCount;
  final String prompt;
  final String imageUrl;
  final String sharedAt;
  final bool isLiked;

  ExploreDesignModel({
    required this.id,
    required this.name,
    required this.avatar,
    required this.likesCount,
    required this.prompt,
    required this.imageUrl,
    required this.sharedAt,
    required this.isLiked,
  });

  factory ExploreDesignModel.fromJson(Map<String, dynamic> json) {
    return ExploreDesignModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      avatar: json['avatar'] ?? '',
      likesCount: json['likesCount'] ?? 0,
      prompt: json['prompt'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      sharedAt: json['sharedAt'] ?? '',
      isLiked: json['isLiked'] ?? false,
    );
  }

  /// Returns a copy with updated like status and count.
  ExploreDesignModel copyWith({
    bool? isLiked,
    int? likesCount,
  }) {
    return ExploreDesignModel(
      id: id,
      name: name,
      avatar: avatar,
      likesCount: likesCount ?? this.likesCount,
      prompt: prompt,
      imageUrl: imageUrl,
      sharedAt: sharedAt,
      isLiked: isLiked ?? this.isLiked,
    );
  }
}
