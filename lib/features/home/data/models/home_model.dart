class HomeModel {
  final String? name;
  final String? avatar;
  final int? credits;

  HomeModel({this.name, this.avatar, this.credits});

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      name: json['name']?.toString(),
      avatar: json['avatar']?.toString(),
      // Backend may send 'credits' or 'tokens' key
      credits: (json['credits'] ?? json['tokens']) is int
          ? (json['credits'] ?? json['tokens'])
          : int.tryParse((json['credits'] ?? json['tokens'])?.toString() ?? ''),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (name != null) 'name': name,
      if (avatar != null) 'avatar': avatar,
      if (credits != null) 'tokens': credits,
    };
  }
}
