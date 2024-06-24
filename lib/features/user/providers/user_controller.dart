import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myapp/features/user/data/error_data.dart';
import 'package:myapp/features/user/repositories/user_repository.dart';
import 'package:myapp/features/user/requests/user_request.dart';
import '../repositories/auth_repository.dart';

class UserController extends StateNotifier<AsyncValue<dynamic>> {
  Ref ref;

  UserController({
    required this.ref,
  }) : super(const AsyncData(null));

  Future<Either<String, bool>> login(
      {required String email, required String password}) async {
    state = const AsyncLoading();

    UserRequest userReq = UserRequest(userName: email, password: password);
    final response = await ref.read(userRepositoryProvider).login(userReq);
    if (response is ErrorResponse || response == null) {
      return Left(response.error.message);
    } else {
      if (response.statusCode == 200) {
        Fluttertoast.showToast(
            msg: 'Đăng nhập thành công dữ chưa',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 26.0);
        await saveAccessToken(response.data.accessToken);
        ref.read(setAuthStateProvider.notifier).state = response.data;
        ref.read(setIsAuthenticatedProvider(true));
        ref.read(setAuthenticatedUserProvider(response.data));
        return const Right(true);
      } else {
        return Left(response.message);
      }
    }

    // final prettyString =
    //     JsonEncoder.withIndent('  ').convert(response.toJson());
    // debugPrint(prettyString);
  }
}

final userControllerProvider =
    StateNotifierProvider<UserController, AsyncValue<dynamic>>((ref) {
  return UserController(ref: ref);
});
