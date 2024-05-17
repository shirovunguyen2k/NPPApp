import 'package:flutter/material.dart';
import 'package:myapp/home-navigation-bar.dart';

/// Flutter code sample for [NavigationBar].

void main() => runApp(const NPPApp());

class NPPApp extends StatelessWidget {
  const NPPApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const HomeNavigation(),
    );
  }
}
