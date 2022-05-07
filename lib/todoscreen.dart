import 'dart:html';

import '../taskscreen.dart';
import 'package:flutter/material.dart';
import './models/todo.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class TodoList extends StatelessWidget {
  final List<Todo> todos;
  const TodoList({Key? key, required this.todos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return GestureDetector(
          child: Container(
            padding: EdgeInsets.all(10.0),
            color: index % 2 == 0 ? Colors.greenAccent : Colors.cyan,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(
                  todos[index].name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                new Text(
                  'Date: ${todos[index].dueDate}',
                  style: TextStyle(fontSize: 16.0),
                )
              ],
            ),
          ),
          onTap: () {
            //bam vao item bat ky trong list view thi nhay ra detail id
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TaskScreen(
                        todoid: todos[index].id,
                      )),
            );
          },
        );
      },
      itemCount: todos.length,
    );
  }
}

class TodoScreen extends StatefulWidget {
  const TodoScreen({Key? key}) : super(key: key);

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fetch todos from resful API"),
      ),
      body: FutureBuilder(
        future: fetchTodos(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
          }
          return snapshot.hasData
              ? TodoList(todos: snapshot.data as List<Todo>)
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}
