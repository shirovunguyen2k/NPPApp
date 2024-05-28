import 'package:dartz/dartz.dart';
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

    UserRequest userReq = UserRequest(email: email, password: password);
    final response = await ref.read(userRepositoryProvider).login(userReq);
    if (response is ErrorResponse) {
      return Left(response.error.message);
    } else {
      ref.read(setAuthStateProvider.notifier).state = response;
      ref.read(setIsAuthenticatedProvider(true));
      ref.read(setAuthenticatedUserProvider(response.user));
      return const Right(true);
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
