import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myapp/features/task/data/tasks_data.dart';
import 'package:myapp/features/task/data/tasks_list.dart';
import 'package:myapp/features/task/repositories/tasks_repository.dart';

final taskDataProvider = FutureProvider<TasksResponse?>((ref) async {
  return ref.watch(taskRepositoryProvider).getTask();
});

final taskListDataProvider = FutureProvider<List<TasksListResponse>?>((ref) async {
  return ref.watch(taskRepositoryProvider).getTaskList();
});