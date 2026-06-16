class ProfileModel {
  final String? id;
  final String? name;
  final String? username;
  final String? email;
  final String? avatar;
  final String? country;
  final String? gender;
  final String? dateOfBirth;
  final bool? verified;
  final String? createdAt;

  ProfileModel({
    this.id,
    this.name,
    this.username,
    this.email,
    this.avatar,
    this.country,
    this.gender,
    this.dateOfBirth,
    this.verified,
    this.createdAt,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    final user = json['user'] as Map<String, dynamic>?;

    return ProfileModel(
      id:
          json['id']?.toString() ??
          json['_id']?.toString() ??
          user?['_id']?.toString() ??
          user?['id']?.toString(),
      name: json['name']?.toString() ?? user?['name']?.toString(),
      username: json['username']?.toString() ?? user?['username']?.toString(),
      email: json['email']?.toString() ?? user?['email']?.toString(),
      avatar: json['avatar']?.toString() ?? user?['avatar']?.toString(),
      country: json['country']?.toString(),
      gender: json['gender']?.toString(),
      dateOfBirth: json['dateOfBirth']?.toString(),
      verified: json['verified'] as bool? ?? user?['verified'] as bool?,
      createdAt:
          json['createdAt']?.toString() ?? user?['createdAt']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (username != null) 'username': username,
      if (email != null) 'email': email,
      if (avatar != null) 'avatar': avatar,
      if (country != null) 'country': country,
      if (gender != null) 'gender': gender,
      if (dateOfBirth != null) 'dateOfBirth': dateOfBirth,
      if (verified != null) 'verified': verified,
      if (createdAt != null) 'createdAt': createdAt,
    };
  }
}
