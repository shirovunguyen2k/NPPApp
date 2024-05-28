import 'dart:convert';

class User {
  final int userId;
  final String userName;
  final String? role;
  final String? accessToken;
  final String? refreshToken;

  const User({
    required this.userId,
    required this.userName,
    this.role,
    this.accessToken,
    this.refreshToken,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['UserId'],
      userName: json['UserName'],
      role: json['Role'],
      accessToken: json['AccessToken'],
      refreshToken: json['RefreshToken'],
    );
  }

  String toJson() {
    return jsonEncode(
      {
        'userId': userId,
        'userName': userName,
        'role': role,
        "accessToken": accessToken,
        "refreshToken": refreshToken,
      },
    );
  }
}
