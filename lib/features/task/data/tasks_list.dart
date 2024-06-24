import 'dart:convert';

import 'package:myapp/features/task/data/tasks_data.dart';

class TasksListResponse {
  final String assigneeId;
  final String assignee;
  final List<TasksResponse> tasks;

  const TasksListResponse(
      {required this.assigneeId, required this.assignee, required this.tasks});

  factory TasksListResponse.fromJson(Map<String, dynamic> json) {
    return TasksListResponse(
      assigneeId: json['assigneeId'],
      assignee: json['assignee'],
      tasks: (json['tasks'] as List<dynamic>)
          .map((e) => TasksResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  String toJson() {
    return jsonEncode(
      {
        'assigneeId': assigneeId,
        'assignee': assignee,
        'tasks': tasks.map((task) => task.toJson()).toList(),
      },
    );
  }
}
