import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../global.dart';
// import 'package:query_params/query_params.dart';

class Task {
  int id;
  String name;
  bool finished;
  int todoId;

  Task({
    required this.id,
    required this.name,
    required this.finished,
    required this.todoId,
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
// Future<List<Task>> fetchTask(http){

// }
