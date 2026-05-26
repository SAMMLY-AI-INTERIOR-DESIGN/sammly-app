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
    return ProfileModel(
      id: json['id']?.toString(),
      name: json['name']?.toString(),
      username: json['username']?.toString(),
      email: json['email']?.toString(),
      avatar: json['avatar']?.toString(),
      country: json['country']?.toString(),
      gender: json['gender']?.toString(),
      dateOfBirth: json['dateOfBirth']?.toString(),
      verified: json['verified'] as bool?,
      createdAt: json['createdAt']?.toString(),
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
