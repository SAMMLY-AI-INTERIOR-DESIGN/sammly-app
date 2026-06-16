class HomeModel {
  final String? name;
  final String? avatar;
  final int? tokens;

  HomeModel({this.name, this.avatar, this.tokens});

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      name: json['name']?.toString(),
      avatar: json['avatar']?.toString(),
      tokens: json['tokens'] is int
          ? json['tokens']
          : int.tryParse(json['tokens']?.toString() ?? ''),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (name != null) 'name': name,
      if (avatar != null) 'avatar': avatar,
      if (tokens != null) 'tokens': tokens,
    };
  }
}
