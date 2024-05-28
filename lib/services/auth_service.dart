import 'dart:convert';
import 'package:myapp/exceptions/form_exceptions.dart';
import 'package:myapp/exceptions/secure_storage_exceptions.dart';
import 'package:myapp/model/base-response-model.dart';
import 'package:myapp/model/user-response-model.dart';
import 'package:myapp/services/end_point.dart';
import 'package:myapp/services/secure_storage_service.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static const String apiUrl = Endpoints.baseURL + Endpoints.loginURL;

  static Future<User> loadUser() async {
    final json = await SecureStorageService.storage.read(
      key: SecureStorageService.userKey,
    );
    if (json != null) {
      return User.fromJson(jsonDecode(json));
    } else {
      throw SecureStorageNotFoundException();
    }
  }

  static void saveUser(User user) async {
    await SecureStorageService.storage.write(
      key: SecureStorageService.userKey,
      value: user.toJson(),
    );
  }

  static Future<void> logout() async {
    await SecureStorageService.storage.delete(
      key: SecureStorageService.userKey,
    );
  }

  static Future<User> login({
    required String email,
    required String password,
  }) async {
    var url = Uri.parse(apiUrl);
    var response = await http.post(
      url,
      headers: <String, String>{
        'X_REQUEST_UDID': '00000000-0000-0000-0000-000000000000',
        'X_TOKEN': '00000000-0000-0000-0000-000000000000',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'UserName': email,
        'Password': password,
      }),
    );

    Map<String, dynamic> data = jsonDecode(response.body);
    BaseResponse<User> res =
        convertResponse<User>(data, (json) => User.fromJson(json));

    final statusType = res.statusCode;
    switch (statusType) {
      case 200:
        final json = jsonDecode(response.body);
        final user = User.fromJson(json);
        saveUser(user);
        return user;
      case 400:
        final json = jsonDecode(response.body);
        throw handleFormErrors(json);
      case 300:
      case 500:
      default:
        throw FormGeneralException(message: 'Error contacting the server!');
    }
  }
}
