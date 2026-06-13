class DesignDetailsResponse {
  final DesignDetailsModel design;
  final DesignCreatorModel? creator;

  DesignDetailsResponse({
    required this.design,
    this.creator,
  });

  factory DesignDetailsResponse.fromJson(Map<String, dynamic> json) {
    return DesignDetailsResponse(
      design: DesignDetailsModel.fromJson(
        json['design'] as Map<String, dynamic>,
      ),
      creator: json['creator'] != null
          ? DesignCreatorModel.fromJson(
              json['creator'] as Map<String, dynamic>,
            )
          : null,
    );
  }
}

class DesignDetailsModel {
  final String id;
  final String prompt;
  final String imageUrl;
  final String room;
  final String style;
  final int likesCount;
  final bool isLiked;
  final bool isFavorited;
  final String? sharedAt;

  DesignDetailsModel({
    required this.id,
    required this.prompt,
    required this.imageUrl,
    required this.room,
    required this.style,
    required this.likesCount,
    required this.isLiked,
    required this.isFavorited,
    this.sharedAt,
  });

  factory DesignDetailsModel.fromJson(Map<String, dynamic> json) {
    return DesignDetailsModel(
      id: json['_id'] ?? '',
      prompt: json['prompt'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      room: json['room'] ?? '',
      style: json['style'] ?? '',
      likesCount: json['likesCount'] ?? 0,
      isLiked: json['isLiked'] ?? false,
      isFavorited: json['isFavorited'] ?? false,
      sharedAt: json['sharedAt'],
    );
  }

  DesignDetailsModel copyWith({
    int? likesCount,
    bool? isLiked,
    bool? isFavorited,
    String? sharedAt,
  }) {
    return DesignDetailsModel(
      id: id,
      prompt: prompt,
      imageUrl: imageUrl,
      room: room,
      style: style,
      likesCount: likesCount ?? this.likesCount,
      isLiked: isLiked ?? this.isLiked,
      isFavorited: isFavorited ?? this.isFavorited,
      sharedAt: sharedAt ?? this.sharedAt,
    );
  }

  /// Whether this design is shared (has a sharedAt date).
  bool get isShared => sharedAt != null;
}

class DesignCreatorModel {
  final String name;
  final String avatar;

  DesignCreatorModel({
    required this.name,
    required this.avatar,
  });

  factory DesignCreatorModel.fromJson(Map<String, dynamic> json) {
    return DesignCreatorModel(
      name: json['name'] ?? '',
      avatar: json['avatar'] ?? '',
    );
  }
}
