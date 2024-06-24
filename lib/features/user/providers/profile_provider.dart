import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myapp/features/user/data/user_profile_data.dart';
import 'package:myapp/services/user_profile_service.dart';

final profileDataProvider = FutureProvider<ProfileResponse?>((ref) async {
  return ref.watch(profileProvider).getUserProfile();
});