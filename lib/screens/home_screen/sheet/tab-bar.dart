import 'package:flutter/material.dart';
import 'package:myapp/screens/home_screen/sheet/tasks-list.dart';

class SheetTabBar extends StatelessWidget {
  const SheetTabBar({super.key});

// Suggested code may be subject to a license. Learn more: ~LicenseLog:4154457928.
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: AppBar(
              title: const Text("Sheet Page"),
              bottom: const TabBar(
                tabs: [
                  Tab(
                    icon: Icon(Icons.pets),
                    text: "Backlog",
                  ),
                  Tab(icon: Icon(Icons.self_improvement), text: "In Process"),
                  Tab(icon: Icon(Icons.pending_actions), text: "Pending"),
                  Tab(icon: Icon(Icons.done), text: "Done"),
                ],
              ),
            ),
            body: const TabBarView(children: [
              TasksList(),
              Icon(Icons.directions_transit),
              Icon(Icons.directions_bike),
            ])));
  }
}
