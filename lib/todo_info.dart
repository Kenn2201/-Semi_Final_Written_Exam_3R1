
import 'package:flutter/material.dart';

class ToDoInfo extends StatefulWidget {

  final dynamic todo;
  const ToDoInfo({required this.todo,Key? key}) : super(key: key);

  @override
  State<ToDoInfo> createState() => _ToDoInfoState();
}

class _ToDoInfoState extends State<ToDoInfo> {


  Widget rowItem(String title, dynamic value) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(title),
        ),
        const SizedBox(width: 5),
        Text(value.toString())
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDo Information'),
      ),
      body:  ListView(
        padding: const EdgeInsets.all(10),
        children: [
          rowItem("ID", widget.todo.id),
          rowItem("User ID", widget.todo.userId),
          rowItem("Title", widget.todo.title),
          rowItem("Completed", widget.todo.completed)
        ],
      ),
    );
  }
}
