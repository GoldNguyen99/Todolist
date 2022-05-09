import 'dart:html';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'models/task.dart';
import 'detailTaskScreen.dart';

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
      body: FutureBuilder(
          future: fetchTask(http.Client(), widget.todoid),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? TaskList(tasks: snapshot.data as List<Task>)
                : Center(
                    child: CircularProgressIndicator(),
                  );
          }),
    );
  }
}

class TaskList extends StatelessWidget {
  final List<Task> tasks;
  TaskList({Key? key, required this.tasks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return GestureDetector(
          child: Container(
            padding: EdgeInsets.all(10.0),
            color: index % 2 == 0 ? Colors.deepOrangeAccent : Colors.amber,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  this.tasks[index].name as String,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
                new Text(
                  'Finished: ${tasks[index].finished == true ? "Yes" : "No"}',
                  style: TextStyle(fontSize: 16.0),
                )
              ],
            ),
          ),
          onTap: () {
            int selectedId = tasks[index].id as int;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => new detailTaskScreen(),
              ),
            );
          },
        );
      },
      itemCount: this.tasks.length,
    );
  }
}
