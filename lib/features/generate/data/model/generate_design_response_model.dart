class GenerateDesignResponseModel {
  final String id;
  final String style;
  final String room;
  final int width;
  final int height;
  final String imageUrl;
  final String prompt;
  final String? aspectRatio;


  GenerateDesignResponseModel({
    required this.id,
    required this.style,
    required this.room,
    required this.width,
    required this.height,
    required this.imageUrl,
    required this.prompt,
    this.aspectRatio,
  });

  factory GenerateDesignResponseModel.fromJson(Map<String, dynamic> json) {
    return GenerateDesignResponseModel(
      id: json['_id'] ?? json['id'] ?? '',
      style: json['style'] ?? '',
      room: json['room'] ?? '',
      width: json['width'] ?? 0,
      height: json['height'] ?? 0,
      imageUrl: json['imageUrl'] ?? '',
      prompt: json['prompt'] ?? '',
      aspectRatio: json['aspect_ratio'],
    );
  }
}
