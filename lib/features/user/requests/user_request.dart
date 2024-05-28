class UserRequest {
  UserRequest({
    required this.email,
    required this.password,
  });

  String email;
  String password;

  factory UserRequest.fromJson(Map<String, dynamic> json) => UserRequest(
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };
}
