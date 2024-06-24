import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myapp/features/task/data/tasks_data.dart';
import 'package:myapp/features/task/data/tasks_list.dart';
import 'package:myapp/features/task/requests/task_request.dart';
import 'package:myapp/model/base-response-model.dart';
import 'package:myapp/services/api_service.dart';
import 'package:myapp/services/end_point.dart';

abstract class TasksRepository {
  Future<TasksResponse?> getTask();
  Future<List<TasksListResponse>?> getTaskList();
  Future<BaseResponse<String>?> addTask(TaskRequest req);
  Future<BaseResponse<String>?> updateTask(TaskRequest req);
  Future<BaseResponse<String>?> deleteTask(String taskId);
}

class TasksRepositoryService implements TasksRepository {
  final apiService = ApiService(Endpoints.baseURL, baseUrl: Endpoints.baseURL);
  @override
  Future<TasksResponse?> getTask() async {
    try {
      final response = await apiService.get(Endpoints.taskURL);
      final baseResponse =
          BaseResponse.fromJson(response, TasksResponse.fromJson);
      if (baseResponse.statusCode == 200) {
        return baseResponse.data;
      } else {
        Fluttertoast.showToast(
            msg: response.message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        return null;
      }
    } catch (error) {
      print('Error fetching data: $error');
      return null;
    }
  }

  @override
  Future<List<TasksListResponse>?> getTaskList() async {
    const queryParameters = {
      'project': '6bf9c24c-a89d-4c79-a09e-08ce3a112f2c',
      'ForMe': 'true',
    };
    try {
      final response = await apiService.get(Endpoints.taskURL, queryParameters);
      final baseResponse = BaseResponse.fromJson(response, (json) {
        return (json as List<dynamic>)
            .map((e) => TasksListResponse.fromJson(e as Map<String, dynamic>))
            .toList();
      });
      if (baseResponse.statusCode == 200) {
        return baseResponse.data;
      } else {
        Fluttertoast.showToast(
            msg: baseResponse.message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        return null;
      }
    } catch (error) {
      print('Error fetching data: $error');
      return null;
    }
  }

  @override
  Future<BaseResponse<String>?> addTask(TaskRequest req) async {
    Map<String, dynamic> rest = req.toJson();
    rest.remove('taskId');
    try {
      final response = await apiService.post(
          '${Endpoints.taskURL}${req.taskId}', jsonEncode(rest));
      return BaseResponse.fromJson(response, (data) => data as String);
    } on DioException catch (ex) {
      print(ex.response?.data);
    }
    return null;
  }

  @override
  Future<BaseResponse<String>?> updateTask(TaskRequest req) async {
    Map<String, dynamic> rest = req.toJson();
    rest.remove('taskId');
    try {
      final response = await apiService.put(
          '${Endpoints.taskURL}${req.taskId}', jsonEncode(rest));
      return BaseResponse.fromJson(response, (data) => data as String);
    } on DioException catch (ex) {
      print(ex.response?.data);
    }
    return null;
  }

  @override
  Future<BaseResponse<String>?> deleteTask(String taskId) async {
    try {
      final response = await apiService.delete('${Endpoints.taskURL}$taskId');
      return BaseResponse.fromJson(response, (data) => data as String);
    } on DioException catch (ex) {
      print(ex.response?.data);
    }
    return null;
  }
}

final taskRepositoryProvider = Provider<TasksRepositoryService>((ref) {
  return TasksRepositoryService();
});
