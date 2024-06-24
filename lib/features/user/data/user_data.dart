import 'dart:convert';

class UserResponse {
  final String? userId;
  final String? accessToken;
  final String? refreshToken;

  const UserResponse({
    required this.userId,
    this.accessToken,
    this.refreshToken,
  });

  factory UserResponse.fromJson(dynamic json) {
    return UserResponse(
      userId: json['userId'],
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
    );
  }

  String toJson() {
    return jsonEncode(
      {
        'userId': userId,
        "accessToken": accessToken,
        "refreshToken": refreshToken,
      },
    );
  }
}
