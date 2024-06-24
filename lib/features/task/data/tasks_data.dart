import 'dart:convert';

class TasksResponse {
  final String? id;
  final String? title;
  final String? description;
  final String? note;
  final String? state;
  final String? stateCode;
  final String? color;
  final String? project;
  final String? projectId;
  final String? sprintTitle;
  final String? sprintCode;
  final String? sprintId;
  final String? startDate;
  final String? dueDate;
  final String? finishDate;
  final String? creator;
  final String? creatorId;
  final String? createdDate;
  final String? priority;
  final String? priorityCode;
  final String? parentTaskId;
  final String? parentTaskTitle;
  final bool? readOnly;
  final int? serialNo; 

  const TasksResponse({
    required this.id,
    this.title,
    this.description,
    this.note,
    this.state,
    this.stateCode,
    this.color,
    this.project,
    this.projectId,
    this.sprintTitle,
    this.sprintCode,
    this.sprintId,
    this.startDate,
    this.dueDate,
    this.finishDate,
    this.creator,
    this.creatorId,
    this.createdDate,
    this.priority,
    this.priorityCode,
    this.parentTaskId,
    this.parentTaskTitle,
    this.readOnly,
    this.serialNo
  });

  factory TasksResponse.fromJson(dynamic json) {
    return TasksResponse(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      note: json['note'],
      state: json['state'],
      stateCode: json['stateCode'],
      color: json['color'],
      project: json['project'],
      projectId: json['projectId'],
      sprintTitle: json['sprintTitle'],
      sprintCode: json['sprintCode'],
      sprintId: json['sprintId'],
      startDate: json['startDate'],
      dueDate: json['dueDate'],
      finishDate: json['finishDate'],
      creator: json['creator'],
      creatorId: json['creatorId'],
      createdDate: json['createdDate'],
      priority: json['priority'],
      priorityCode: json['priorityCode'],
      parentTaskId: json['parentTaskId'],
      parentTaskTitle: json['parentTaskTitle'],
      readOnly: json['readOnly'],
      serialNo: json['serialNo']
    );
  }

  String toJson() {
    return jsonEncode(
      {
        'id': id,
        "title": title,
        "description": description,
        "note": note,
        "state": state,
        "stateCode": stateCode,
        "color": color,
        "project": project,
        "projectId": projectId,
        "sprintTitle": sprintTitle,
        "sprintCode": sprintCode,
        "sprintId": sprintId,
        "startDate": startDate,
        "dueDate": dueDate,
        "finishDate": finishDate,
        "creator": creator,
        "creatorId": creatorId,
        "createdDate": createdDate,
        "priority": priority,
        "priorityCode": priorityCode,
        "parentTaskId": parentTaskId,
        "parentTaskTitle": parentTaskTitle,
        "readOnly": readOnly,
        "serialNo": serialNo
      },
    );
  }
}
