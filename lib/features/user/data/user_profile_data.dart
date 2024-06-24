import 'dart:convert';

class ProfileResponse {
  final String? id;
  final String? fullName;
  final String? email;
  final String? address;
  final String? tel;
  final String? department;
  final String? departmentId;
  final String? workStartDate;
  final String? avatarUrl;

  const ProfileResponse({
    required this.id,
    this.fullName,
    this.email,
    this.address,
    this.tel,
    this.department,
    this.departmentId,
    this.workStartDate,
    this.avatarUrl,
  });

  factory ProfileResponse.fromJson(dynamic json) {
    return ProfileResponse(
      id: json['id'],
      fullName: json['fullName'],
      email: json['email'],
      address: json['address'],
      tel: json['tel'],
      department: json['department'],
      departmentId: json['departmentId'],
      workStartDate: json['workStartDate'],
      avatarUrl: json['avatarUrl'],
    );
  }

  String toJson() {
    return jsonEncode(
      {
        'id': id,
        "fullName": fullName,
        "email": email,
        "address": address,
        "tel": tel,
        "department": department,
        "departmentId": departmentId,
        "workStartDate": workStartDate,
        "avatarUrl": avatarUrl,
      },
    );
  }
}
