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
      designs:
          (json['designs'] as List<dynamic>?)
              ?.map(
                (e) => HistoryDesignModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
    );
  }
}

class HistoryDesignModel {
  final String id;
  final String imageUrl;
  final String? prompt;
  final String createdAt;
  final String? generationType;
  final String? groupId;
  final String? parentDesignUrl;
  final String? room;
  final String? style;

  HistoryDesignModel({
    required this.id,
    required this.imageUrl,
    this.prompt,
    required this.createdAt,
    this.generationType,
    this.groupId,
    this.parentDesignUrl,
    this.room,
    this.style,
  });

  factory HistoryDesignModel.fromJson(Map<String, dynamic> json) {
    return HistoryDesignModel(
      id: json['_id'] ?? json['id'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      prompt: json['prompt'],
      createdAt: json['createdAt'] ?? '',
      generationType: json['generationType'],
      groupId: json['groupId'],
      parentDesignUrl: json['parentDesignUrl'],
      room: json['room'],
      style: json['style'],
    );
  }
}

class HistoryDesignDetails {
  final bool isFavorited;
  final bool isShared;

  HistoryDesignDetails({
    required this.isFavorited,
    required this.isShared,
  });

  factory HistoryDesignDetails.fromJson(Map<String, dynamic> json) {
    final design = json['design'] ?? {};
    return HistoryDesignDetails(
      isFavorited: design['isFavorited'] ?? false,
      isShared: design['isShared'] ?? false,
    );
  }
}
