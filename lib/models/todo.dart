import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../global.dart';

class Todo {
  int id;
  String name;
  String dueDate;
  String description;
  //constructor
  Todo({
    required this.id,
    required this.name,
    required this.dueDate,
    required this.description,
  });
//static method
  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      //convert 1 doi tuoq, tu 1 key value qua 1 object todo
      id: json["id"],
      name: json["name"],
      dueDate: json["dueDate"],
      description: json["description"],
    );
  }
}

//
Future<List<Todo>> fetchTodos(http.Client client) async {
  //How to make these Url in a .dart file?
  // final response = await client.get(Uri.parse("http://localhost:3000/todos"));
  final response = await client.get(Uri.parse(URL_TODOS));
  if (response.statusCode == 200) {
    Map<String, dynamic> mapResponse = json.decode(response.body);
    if (mapResponse["result"] == "ok") {
      final todos = mapResponse["data"].cast<Map<String, dynamic>>();
      final listOfTodos = await todos.map<Todo>((json) {
        return Todo.fromJson(json);
      }).toList();
      return listOfTodos;
    } else {
      return [];
    }
  } else {
    throw Exception('Failed to load Todo from the Internet');
  }
}
