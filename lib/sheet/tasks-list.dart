// Suggested code may be subject to a license. Learn more: ~LicenseLog:420035232.
// Suggested code may be subject to a license. Learn more: ~LicenseLog:3649466538.
// Suggested code may be subject to a license. Learn more: ~LicenseLog:2032247667.
import 'package:flutter/material.dart';
import 'package:myapp/sheet/task-item.dart';

class Task {
  final String title;
  final String description;
  final DateTimeRange formTo;
  final String priority;
  final String avatarUrl;
  final bool isCompleted;
  Task(this.description, this.formTo, this.priority, this.avatarUrl,
      {required this.title, this.isCompleted = false});
}

class _TasksListState extends State<TasksList> {
  List<Task> tasks = [
    Task(
      'My Class Task',
      DateTimeRange(
        start: DateTime.now(),
        end: DateTime.now().add(const Duration(days: 1)),
      ),
      'High',
      'https://avatar.iran.liara.run/public',
      title: 'Task 1',
    ),
    Task(
      'My Class Task 2',
      DateTimeRange(
        start: DateTime.now(),
        end: DateTime.now().add(const Duration(days: 1)),
      ),
      'High',
      'https://avatar.iran.liara.run/public',
      title: 'Task 2',
    ),
    Task(
      'My Class Task 3',
      DateTimeRange(
        start: DateTime.now(),
        end: DateTime.now().add(const Duration(days: 1)),
      ),
      'High',
      'https://avatar.iran.liara.run/public',
      title: 'Task 3',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return TaskItem(task: tasks[index]);
      },
    );
  }
}

class TasksList extends StatefulWidget {
  const TasksList({super.key});

  @override
  State<TasksList> createState() => _TasksListState();
}
