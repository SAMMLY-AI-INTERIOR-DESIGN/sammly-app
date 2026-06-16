class SearchResponse {
  final String status;
  final List<SourcingResult> data;

  SearchResponse({required this.status, required this.data});

  factory SearchResponse.fromJson(Map<String, dynamic> json) {
    List<dynamic> sourcingList = [];

    if (json['data'] is Map) {
      final mapData = json['data'] as Map<String, dynamic>;
      if (mapData['metadata'] is Map &&
          mapData['metadata']['sourcing_results'] is List) {
        sourcingList = mapData['metadata']['sourcing_results'] as List<dynamic>;
      } else if (mapData['sourcing_results'] is List) {
        sourcingList = mapData['sourcing_results'] as List<dynamic>;
      } else if (mapData['data'] is List) {
        sourcingList = mapData['data'] as List<dynamic>;
      }
    } else if (json['data'] is List) {
      sourcingList = json['data'] as List<dynamic>;
    }

    return SearchResponse(
      status: json['status']?.toString() ?? '',
      data: sourcingList
          .map((e) => SourcingResult.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class SourcingResult {
  final String detectedCategory;
  final String label;
  final String cropUrl;
  final List<ProductMatch> productMatches;

  SourcingResult({
    required this.detectedCategory,
    required this.label,
    required this.cropUrl,
    required this.productMatches,
  });

  factory SourcingResult.fromJson(Map<String, dynamic> json) {
    // The JSON might wrap the actual item details in an 'item' object
    final itemJson = json['item'] as Map<String, dynamic>? ?? json;

    // Products might be in 'top_matches', 'final_matches', 'visual_matches', or 'product_matches'
    List<dynamic> matchesList = [];
    if (json['top_matches'] is List) {
      matchesList = json['top_matches'] as List<dynamic>;
    } else if (itemJson['final_matches'] is List) {
      matchesList = itemJson['final_matches'] as List<dynamic>;
    } else if (itemJson['visual_matches'] is List) {
      matchesList = itemJson['visual_matches'] as List<dynamic>;
    } else if (itemJson['product_matches'] is List) {
      matchesList = itemJson['product_matches'] as List<dynamic>;
    }

    return SourcingResult(
      detectedCategory: itemJson['detected_category']?.toString() ?? '',
      label: itemJson['label']?.toString() ?? '',
      cropUrl: itemJson['crop_url']?.toString() ?? '',
      productMatches: matchesList
          .map((e) => ProductMatch.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class ProductMatch {
  final String title;
  final String price;
  final String url;
  final String thumbnail;

  ProductMatch({
    required this.title,
    required this.price,
    required this.url,
    required this.thumbnail,
  });

  factory ProductMatch.fromJson(Map<String, dynamic> json) {
    return ProductMatch(
      title: json['title']?.toString() ?? '',
      price: json['price']?.toString() ?? '',
      url: json['url']?.toString() ?? '',
      thumbnail: json['thumbnail']?.toString() ?? '',
    );
  }
}
