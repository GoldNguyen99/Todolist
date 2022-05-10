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
      onPressed: () async {
        Map<String, dynamic> params = Map<String, dynamic>();
        params["id"] = this.task.id.toString();
        params["name"] = this.task.name;
        params["isfinished"] = this.task.finished != null ? "1" : "0";
        params["todoid"] = this.task.todoId.toString();
        await updateTask(http.Client(), params);
        Navigator.pop(context); //quay lai man hinh truoc do de xem cap nhat
      },
    );
    final _btndelete = RaisedButton(
      child: Text("delete"),
      color: Colors.redAccent,
      elevation: 4.0,
      onPressed: () async {
        // await deleteTask(http.Client(), this.task.id as int);
        // Navigator.pop(context);
        showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Confirmation"),
              content: SingleChildScrollView(
                child: ListBody(children: <Widget>[
                  Text("Are you sure you want to delete"),
                ]),
              ),
              actions: <Widget>[
                new FlatButton(
                  child: new Text('Yes'),
                  onPressed: () async {
                    await deleteTask(http.Client(), this.task.id as int);
                    // await Navigator.pop(context); //quit dialog
                    Navigator.pop(context); //quit to previous screen
                  },
                ),
                new FlatButton(
                  child: new Text('No'),
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        );
      },
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
            Expanded(child: _btndelete),
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
