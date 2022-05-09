import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../global.dart';
// import 'package:query_params/query_params.dart';

class Task {
  int? id;
  String? name;
  bool? finished;
  int? todoId;

  Task({
    this.id,
    this.name,
    this.finished,
    this.todoId,
  });
  factory Task.fromJson(Map<String, dynamic> json) {
    Task newTask = Task(
      //convert 1 doi tuoq, tu 1 key value qua 1 object todo
      id: json["id"],
      name: json["name"],
      finished: json["isfinished"],
      todoId: json["todoid"],
    );
    return newTask;
  }
  //clone a Task, or "Copy constructor"
  factory Task.fromTask(Task anotherTask) {
    return Task(
      id: anotherTask.id,
      name: anotherTask.name,
      finished: anotherTask.finished,
      todoId: anotherTask.todoId,
    );
  }
}

//controller = "functions relating to Task"
Future<List<Task>> fetchTask(http.Client client, int todoId) async {
  final response = await client.get(Uri.parse('$URL_TASK_BY_TODOID$todoId'));
  if (response.statusCode == 200) {
    Map<String, dynamic> mapResponse = json.decode(response.body);
    if (mapResponse['result'] == "OK") {
      final task = mapResponse["data"].cast<Map<String, dynamic>>();
      return task.map<Task>((json) {
        return Task.fromJson(json);
      }).toList();
    } else {
      return [];
    }
  } else {
    throw Exception('Failed to load Task');
  }
}

//fetch task by id: lay ra noi dung cua task tuoq ung id dau vao
Future<Task> fetchTaskById(http.Client client, int id) async {
  final String url = '$URL_TASKS/$id';
  // print('url = $url');

  final respone = await client.get(Uri.parse(url));
  if (respone.statusCode == 200) {
    Map<String, dynamic> mapResponse = json.decode(respone.body);
    if (mapResponse["result"] == "ok") {
      Map<String, dynamic> mapTask = mapResponse["data"];
      return Task.fromJson(mapTask);
    } else {
      return Task();
    }
  } else {
    throw Exception('Failed to get detail task with Id = {id}');
  }
}
