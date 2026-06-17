class SharedImageModel {
  final String title;
  final String description;
  final String imageUrl;
  final int likes;
  final bool isLiked;

  SharedImageModel({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.likes,
    this.isLiked = false,
  });
}
