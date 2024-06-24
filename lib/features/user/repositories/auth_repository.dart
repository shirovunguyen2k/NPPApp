import 'dart:convert';
import 'package:myapp/features/user/data/user_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

const IS_AUTHENTICATED_KEY = 'IS_AUTHENTICATED_KEY';
const AUTHENTICATED_USER_EMAIL_KEY = 'AUTHENTICATED_USER_EMAIL_KEY';

final sharedPrefProvider = Provider((_) async {
  return await SharedPreferences.getInstance();
});

final setAuthStateProvider = StateProvider<UserResponse?>(
  (ref) => null,
);

final setIsAuthenticatedProvider = StateProvider.family<void, bool>(
  (ref, isAuth) async {
    final prefs = await ref.watch(sharedPrefProvider);
    ref.watch(setAuthStateProvider);
    prefs.setBool(
      IS_AUTHENTICATED_KEY,
      isAuth,
    );
  },
);

final setAuthenticatedUserProvider = StateProvider.family<void, UserResponse>(
  (ref, userdata) async {
    final prefs = await ref.watch(sharedPrefProvider);
    ref.watch(setAuthStateProvider);
    prefs.setString(
      AUTHENTICATED_USER_EMAIL_KEY,
      json.encode(userdata),
    );
  },
);

final getIsAuthenticatedProvider = FutureProvider<bool>(
  (ref) async {
    final prefs = await ref.watch(sharedPrefProvider);
    ref.watch(setAuthStateProvider);
    return prefs.getBool(IS_AUTHENTICATED_KEY) ?? false;
  },
);

final getAuthenticatedUserProvider = FutureProvider<UserResponse>(
  (ref) async {
    final prefs = await ref.watch(sharedPrefProvider);
    ref.watch(setAuthStateProvider);
    dynamic user =
        json.decode(prefs.getString(AUTHENTICATED_USER_EMAIL_KEY) ?? "");
    return UserResponse.fromJson(user);
  },
);

Future<void> saveAccessToken(String token) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('accessToken');
  await prefs.setString('accessToken', token);
}

Future<String?> getAccessToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('accessToken');
}

Future<void> removeAsscessToken() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('accessToken');
  await prefs.reload();
}

//
// Todo: Handle logout or and reset
final resetStorage = StateProvider<dynamic>(
  (ref) async {
    final prefs = await ref.watch(sharedPrefProvider);
    final isCleared = await prefs.clear();
    await prefs.remove(AUTHENTICATED_USER_EMAIL_KEY);
    await prefs.remove(IS_AUTHENTICATED_KEY);
    await prefs.remove("accessToken");
    return isCleared;
  },
);
