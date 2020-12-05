import 'package:flutter/material.dart';

class AddTodo extends StatelessWidget {
  final TextEditingController textController;
  final Function addTodo;

  AddTodo({this.textController, this.addTodo});

  Widget build(BuildContext context) => Row(
        children: <Widget>[
          Expanded(
              child: TextFormField(
            decoration: InputDecoration(hintText: 'Enter Task'),
            controller: textController,
          )),
          IconButton(icon: Icon(Icons.add), onPressed: addTodo)
        ],
      );
}
