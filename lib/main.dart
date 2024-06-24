import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myapp/features/user/repositories/auth_repository.dart';
import 'package:myapp/screens/dashboard/dashboard_screen.dart';
import 'package:myapp/screens/login_screen/login_screen.dart';

void main() => runApp(const ProviderScope(child: NPPApp()));

class NPPApp extends HookConsumerWidget {
  const NPPApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      title: "NPP App",
      home: ref
          .watch(
            getIsAuthenticatedProvider,
          )
          .when(
            data: (bool isAuthenticated) =>
                isAuthenticated ? const DashboardScreen() : const LoginScreen(),
            loading: () {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
            error: (error, stacktrace) => const Text("Error Page !"),
          ),
      routes: {
        "Home": (context) => const DashboardScreen(),
        "Login": (context) => const LoginScreen(),
      },
    );
  }
}
