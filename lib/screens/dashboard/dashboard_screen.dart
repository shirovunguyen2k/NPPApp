import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myapp/features/user/repositories/auth_repository.dart';
import 'package:myapp/screens/home_screen/home-navigation-bar.dart';

class DashboardScreen extends HookConsumerWidget {
  const DashboardScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ref.watch(getAuthenticatedUserProvider).when(
                  loading: () => const CircularProgressIndicator(),
                  data: (user) => const HomeNavigation(),
                  error: (error, stackTrace) {
                    debugPrint(error.toString());
                    return const HomeNavigation();
                  },
                ),
          ],
        ),
      ),
    );
  }
}
