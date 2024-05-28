import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myapp/features/user/data/user_data.dart';
import 'package:myapp/features/user/requests/user_request.dart';
import 'package:dio/dio.dart';
import 'package:myapp/services/end_point.dart';

abstract class UserRepository {
  Future<dynamic> login(UserRequest req);
}

class UserRepositoryImpl implements UserRepository {
  late Dio _dio;

  UserRepositoryImpl() {
    _dio = Dio(
      BaseOptions(
        baseUrl: Endpoints.baseURL,
        responseType: ResponseType.json,
      ),
    );
  }

  @override
  Future<dynamic> login(UserRequest request) async {
    try {
      final response =
          await _dio.post(Endpoints.loginURL, data: request.toJson());
      return UserResponse.fromJson(response.data);
    } on DioException catch (ex) {
      return print(ex.response?.data);
    }
  }
}

final userRepositoryProvider = Provider<UserRepositoryImpl>((ref) {
  return UserRepositoryImpl();
});
