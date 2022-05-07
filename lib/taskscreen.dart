import 'dart:html';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class TaskScreen extends StatefulWidget {
  final int todoid;
  TaskScreen({required this.todoid}) : super();

  @override
  State<StatefulWidget> createState() {
    return _TaskScreenState();
  }
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List of Tasks"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              //bam vao them 1 task moi
            },
          )
        ],
      ),
      body: Text("LIST TASK HERE!!"),
    );
  }
}
