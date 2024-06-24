import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myapp/features/user/data/user_data.dart';
import 'package:myapp/features/user/data/user_profile_data.dart';
import 'package:myapp/features/user/requests/user_request.dart';
import 'package:dio/dio.dart';
import 'package:myapp/model/base-response-model.dart';
import 'package:myapp/services/api_service.dart';
import 'package:myapp/services/end_point.dart';
import 'package:http/http.dart' as http;

abstract class UserRepository {
  Future<dynamic> login(UserRequest req);
}

class UserRepositoryImpl implements UserRepository {
  late final ApiService apiService;
  @override
  Future<dynamic> login(UserRequest request) async {
    var url = Uri.https(Endpoints.baseURL, Endpoints.loginURL);
    try {
      var response = await http.post(
        url,
        headers: <String, String>{
          'X_REQUEST_UDID': '00000000-0000-0000-0000-000000000000',
          'X_TOKEN': '00000000-0000-0000-0000-000000000000',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(request),
      );
      Map<String, dynamic> data = jsonDecode(response.body);
      return BaseResponse.fromJson(data, UserResponse.fromJson);
    } on DioException catch (ex) {
      return print(ex.response?.data);
    }
  }

  Future<ProfileResponse?> getUserProfile() async {
    try {
      final response = await apiService.get(Endpoints.profileURL);
      final baseResponse =
          BaseResponse.fromJson(response, ProfileResponse.fromJson);
      if (baseResponse.statusCode == 200) {
        return baseResponse.data;
      } else {
        Fluttertoast.showToast(
            msg: response.message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        return null;
      }
    } catch (error) {
      print('Error fetching data: $error');
      return null;
    }
  }
}

final userRepositoryProvider = Provider<UserRepositoryImpl>((ref) {
  return UserRepositoryImpl();
});
