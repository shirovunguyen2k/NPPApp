import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myapp/app_states/nav_states/nav_notifier.dart';
import 'package:myapp/screens/home_screen/profile/user-profile.dart';
import 'package:myapp/screens/home_screen/sheet/tab-bar.dart';
import 'package:myapp/screens/home_screen/timeline/timeline.dart';

class HomeNavigation extends ConsumerStatefulWidget {
  const HomeNavigation({super.key});

  @override
  ConsumerState<HomeNavigation> createState() => _HomeNavigation();
}

class _HomeNavigation extends ConsumerState<HomeNavigation> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    var navIndex = ref.watch(navProvider);
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          ref.read(navProvider.notifier).updateIndex(index);
        },
        indicatorColor: const Color.fromARGB(255, 32, 188, 240),
        selectedIndex: navIndex.index,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Timeline',
          ),
          NavigationDestination(
            icon: Icon(Icons.list_sharp, size: 30),
            label: 'Sheet',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.add_circle_outline,
              size: 50,
              color: Colors.green,
            ),
            label: '',
          ),
          NavigationDestination(
            icon: Icon(Icons.receipt_long),
            label: 'Reminder',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings),
            label: 'QA/QC',
          ),
        ],
      ),
      body: <Widget>[
        /// Home page
        const TimelinePage(),

        const SheetTabBar(),

        UserProfileScreen(),

        /// Notifications page
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Card(
                child: ListTile(
                  leading: Icon(Icons.notifications_sharp),
                  title: Text('Notification 1'),
                  subtitle: Text('This is a notification'),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.notifications_sharp),
                  title: Text('tôi là vũ mập đây'),
                  subtitle: Text('This is a notification'),
                ),
              ),
            ],
          ),
        ),

        /// Messages page
        ListView.builder(
          reverse: true,
          itemCount: 2,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Align(
                alignment: Alignment.centerRight,
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    'Hello',
                    style: theme.textTheme.bodyLarge!
                        .copyWith(color: theme.colorScheme.onPrimary),
                  ),
                ),
              );
            }
            return Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  'Hi!',
                  style: theme.textTheme.bodyLarge!
                      .copyWith(color: theme.colorScheme.onPrimary),
                ),
              ),
            );
          },
        ),
      ][navIndex.index],
    );
  }
}
