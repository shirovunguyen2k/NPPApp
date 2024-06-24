class TaskRequest {
  TaskRequest({
    required this.taskId,
    this.assigneeId,
    this.title,
    this.startDate,
    this.dueDate,
    this.projectId,
    this.sprintId,
    this.parentTaskId,
    this.wbs,
  });

  String taskId;
  String? assigneeId;
  String? title;
  String? startDate;
  String? dueDate;
  String? projectId;
  String? sprintId;
  String? parentTaskId;
  bool? wbs;

  factory TaskRequest.fromJson(Map<String, dynamic> json) => TaskRequest(
        assigneeId: json["assigneeId"],
        title: json["title"],
        startDate: json["startDate"],
        dueDate: json["dueDate"],
        projectId: json["projectId"],
        sprintId: json["sprintId"],
        parentTaskId: json["parentTaskId"],
        wbs: json["wbs"],
        taskId: json["taskId"],
      );

  Map<String, dynamic> toJson() => {
        "assigneeId": assigneeId,
        "title": title,
        "startDate": startDate,
        "dueDate": dueDate,
        "projectId": projectId,
        "sprintId": sprintId,
        "parentTaskId": parentTaskId,
        "wbs": wbs,
        "taskId": taskId,
      };
}
