class StaticDesignsResponse {
  final int page;
  final bool hasMore;
  final List<StaticDesignModel> designs;

  StaticDesignsResponse({
    required this.page,
    required this.hasMore,
    required this.designs,
  });

  factory StaticDesignsResponse.fromJson(Map<String, dynamic> json) {
    return StaticDesignsResponse(
      page: json['page'] ?? 1,
      hasMore: json['hasMore'] ?? false,
      designs: (json['designs'] as List<dynamic>?)
              ?.map((e) => StaticDesignModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

class StaticDesignModel {
  final String id;
  final String imageUrl;
  final bool isFavorited;

  StaticDesignModel({
    required this.id,
    required this.imageUrl,
    required this.isFavorited,
  });

  factory StaticDesignModel.fromJson(Map<String, dynamic> json) {
    return StaticDesignModel(
      id: json['_id'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      isFavorited: json['isFavorited'] ?? false,
    );
  }

  StaticDesignModel copyWith({
    bool? isFavorited,
  }) {
    return StaticDesignModel(
      id: id,
      imageUrl: imageUrl,
      isFavorited: isFavorited ?? this.isFavorited,
    );
  }
}
