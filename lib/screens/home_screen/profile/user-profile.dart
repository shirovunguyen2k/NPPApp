import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myapp/features/user/providers/profile_provider.dart';
import 'package:myapp/screens/home_screen/profile/profile-screen.dart';

class UserProfileScreen extends ConsumerWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileData = ref.watch(profileDataProvider);

    return Scaffold(
        body: profileData.when(
            data: (data) => ProfileScreen(profileData: data),
            error: (error, stacktrace) => const Text("Error Page !"),
            loading: () => const Center(child: CircularProgressIndicator())));
  }
}
