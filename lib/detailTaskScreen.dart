import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'models/task.dart';

class detailTaskScreen extends StatefulWidget {
  final int? id;
  detailTaskScreen({this.id}) : super();
  @override
  State<StatefulWidget> createState() {
    return _detailTaskScreenState();
  }
}

class _detailTaskScreenState extends State<detailTaskScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail task"),
      ),
      body: FutureBuilder(
        future: fetchTaskById(http.Client(), widget.id as int),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          if (snapshot.hasData) {
            return Detailtask(task: snapshot.data as Task);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

//ben trong co thuoc tinh thay doi nen dung stateful
class Detailtask extends StatefulWidget {
  final Task task;
  Detailtask({Key? key, required this.task}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _detailTaskScreenState();
  }
}

class _DetailTaskState extends State<Detailtask> {
  Task task = new Task();
  bool isLoadedTask = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (isLoadedTask == false) {
      setState(() {
        this.task = Task.fromTask(widget.task);
        this.isLoadedTask = true;
      });
    }
    final TextField _txttaskName = new TextField(
      decoration: InputDecoration(
        hintText: "Enter task 's Name",
        contentPadding: EdgeInsets.all(10.0),
        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
      ),
      autocorrect: false,
      controller: TextEditingController(text: this.task.name),
      textAlign: TextAlign.left,
      onChanged: (text) {
        setState(() {
          this.task.name = text;
        });
      },
    );
    final Text _txtFinished = Text(
      "Finished : ",
      style: TextStyle(fontSize: 16),
    );
    final Checkbox _cbFinished = Checkbox(
      value: this.task.finished,
      onChanged: (bool? value) {
        setState(() {
          this.task.finished = value;
        });
      },
    );
    final _btnSave = RaisedButton(
      child: Text("Save"),
      color: Theme.of(context).accentColor,
      elevation: 4.0,
      onPressed: () {},
    );
    final _column = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        _txttaskName,
        Container(
          padding: EdgeInsets.only(left: 10.0, right: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              _txtFinished,
              _cbFinished,
            ],
          ),
        ),
        Row(
          children: <Widget>[
            Expanded(child: _btnSave),
          ],
        ),
      ],
    );
    return Container(
      margin: EdgeInsets.all(10.0),
      child: _column,
    );
  }
}
