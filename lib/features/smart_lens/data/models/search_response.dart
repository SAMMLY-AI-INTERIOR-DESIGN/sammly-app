/// Response model for POST /api/sourcing/search
class SearchResponse {
  final String status;
  final bool isValid;
  final bool matchFound;
  final String quality;
  final String? primaryCategory;
  final List<String> detectedCategories;
  final String visualDescription;
  final List<String> detectedElements;
  final List<SourcingMatch> matches;
  final int totalResults;
  final int spentCredits;
  final int remainingCredits;
  final String? message;

  SearchResponse({
    required this.status,
    required this.isValid,
    required this.matchFound,
    required this.quality,
    this.primaryCategory,
    required this.detectedCategories,
    required this.visualDescription,
    required this.detectedElements,
    required this.matches,
    required this.totalResults,
    required this.spentCredits,
    required this.remainingCredits,
    this.message,
  });

  factory SearchResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? json;

    return SearchResponse(
      status: json['status']?.toString() ?? '',
      isValid: data['isValid'] == true,
      matchFound: data['matchFound'] == true,
      quality: data['quality']?.toString() ?? 'none',
      primaryCategory: data['primaryCategory']?.toString(),
      detectedCategories: _parseStringList(data['detectedCategories']),
      visualDescription: data['visualDescription']?.toString() ?? '',
      detectedElements: _parseStringList(data['detectedElements']),
      matches: _parseMatches(data['matches']),
      totalResults: data['totalResults'] as int? ?? 0,
      spentCredits: data['spentCredits'] as int? ?? 0,
      remainingCredits: data['remainingCredits'] as int? ?? 0,
      message: data['message']?.toString(),
    );
  }

  static List<String> _parseStringList(dynamic list) {
    if (list is List) {
      return list.map((e) => e.toString()).toList();
    }
    return [];
  }

  static List<SourcingMatch> _parseMatches(dynamic list) {
    if (list is List) {
      return list
          .map((e) => SourcingMatch.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    return [];
  }
}

/// A single matched product from the sourcing search
class SourcingMatch {
  final String title;
  final String price;
  final String url;
  final String thumbnail;
  final String category;
  final double similarity;

  SourcingMatch({
    required this.title,
    required this.price,
    required this.url,
    required this.thumbnail,
    required this.category,
    required this.similarity,
  });

  factory SourcingMatch.fromJson(Map<String, dynamic> json) {
    return SourcingMatch(
      title: json['title']?.toString() ?? '',
      price: json['price']?.toString() ?? '',
      url: json['url']?.toString() ?? '',
      thumbnail: json['thumbnail']?.toString() ?? '',
      category: json['category']?.toString() ?? '',
      similarity: (json['similarity'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
