class UserRequest {
  UserRequest({
    required this.userName,
    required this.password,
  });

  String userName;
  String password;

  factory UserRequest.fromJson(Map<String, dynamic> json) => UserRequest(
        userName: json["userName"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "userName": userName,
        "password": password,
      };
}
