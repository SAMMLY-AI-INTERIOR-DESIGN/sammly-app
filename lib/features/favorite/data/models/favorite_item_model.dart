class FavoriteModel {
  final String id;
  final String imageUrl;

  FavoriteModel({required this.id, required this.imageUrl});

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
      id: json['_id'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
    );
  }
}

class FavoriteResponse {
  final int page;
  final int limit;
  final bool hasMore;
  final List<FavoriteModel> designs;

  FavoriteResponse({
    required this.page,
    required this.limit,
    required this.hasMore,
    required this.designs,
  });

  factory FavoriteResponse.fromJson(Map<String, dynamic> json) {
    final pagination = json['pagination'] as Map<String, dynamic>? ?? {};
    return FavoriteResponse(
      page: pagination['page'] ?? 1,
      limit: pagination['limit'] ?? 20,
      hasMore: pagination['hasMore'] ?? false,
      designs:
          (json['designs'] as List<dynamic>?)
              ?.map((e) => FavoriteModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}
