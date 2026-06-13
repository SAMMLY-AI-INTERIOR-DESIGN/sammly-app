class HistoryResponse {
  final int page;
  final int totalDesigns;
  final bool hasMore;
  final List<HistoryDesignModel> designs;

  HistoryResponse({
    required this.page,
    required this.totalDesigns,
    required this.hasMore,
    required this.designs,
  });

  factory HistoryResponse.fromJson(Map<String, dynamic> json) {
    return HistoryResponse(
      page: json['page'] ?? 1,
      totalDesigns: json['totalDesigns'] ?? 0,
      hasMore: json['hasMore'] ?? false,
      designs: (json['designs'] as List<dynamic>?)
              ?.map((e) => HistoryDesignModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

class HistoryDesignModel {
  final String id;
  final String imageUrl;
  final String prompt;
  final String createdAt;

  HistoryDesignModel({
    required this.id,
    required this.imageUrl,
    required this.prompt,
    required this.createdAt,
  });

  factory HistoryDesignModel.fromJson(Map<String, dynamic> json) {
    return HistoryDesignModel(
      id: json['_id'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      prompt: json['prompt'] ?? '',
      createdAt: json['createdAt'] ?? '',
    );
  }
}
