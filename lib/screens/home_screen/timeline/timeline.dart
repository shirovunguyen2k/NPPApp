import 'package:flutter/material.dart';
import 'package:myapp/screens/home_screen/timeline/table-calendar.dart';

class _TimelinePage extends State<TimelinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text(
            'Timeline',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: const Center(
          child: TimelineTableCalendar(),
        ));
  }
}

class TimelinePage extends StatefulWidget {
  const TimelinePage({super.key});

  @override
  State<TimelinePage> createState() => _TimelinePage();
}
