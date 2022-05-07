import 'package:apilisttodoapp/models/todoscreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final materialApp = MaterialApp(
      title: '',
      home: TodoScreen(),
    );
    return materialApp;
  }
}
