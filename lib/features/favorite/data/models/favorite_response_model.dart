class FavoriteResponseModel {
  final PaginationModel pagination;
  final List<FavoriteDesignModel> designs;

  FavoriteResponseModel({required this.pagination, required this.designs});

  factory FavoriteResponseModel.fromJson(Map<String, dynamic> json) {
    return FavoriteResponseModel(
      pagination: PaginationModel.fromJson(json['pagination'] ?? {}),
      designs:
          (json['designs'] as List<dynamic>?)
              ?.map((e) => FavoriteDesignModel.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class PaginationModel {
  final int page;
  final int limit;
  final bool hasMore;

  PaginationModel({
    required this.page,
    required this.limit,
    required this.hasMore,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json) {
    return PaginationModel(
      page: json['page'] ?? 1,
      limit: json['limit'] ?? 20,
      hasMore: json['hasMore'] ?? false,
    );
  }
}

class FavoriteDesignModel {
  final String id;
  final String imageUrl;

  FavoriteDesignModel({required this.id, required this.imageUrl});

  factory FavoriteDesignModel.fromJson(Map<String, dynamic> json) {
    return FavoriteDesignModel(
      id: json['_id'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
    );
  }
}
