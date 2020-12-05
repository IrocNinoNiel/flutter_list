import 'package:flutter/material.dart';
import 'package:sql_flutter3/model/todo.dart';

class ListItems extends StatelessWidget {
  final Todo todo;
  final Function updateTodo;
  final Function deleteTodo;

  ListItems({this.todo, this.updateTodo, this.deleteTodo});

  Widget build(BuildContext context) => ListTile(
        leading: IconButton(
            icon: Icon(todo.getStatus()
                ? Icons.check_box
                : Icons.check_box_outline_blank),
            onPressed: updateTodo),
        title: Text(todo.getTitle()),
        trailing: IconButton(icon: Icon(Icons.delete), onPressed: deleteTodo),
      );
}
