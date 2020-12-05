import 'package:flutter/material.dart';
import 'package:sql_flutter3/model/todo.dart';
import 'package:sql_flutter3/views/widget/addtodo.dart';
import 'package:sql_flutter3/views/widget/listitems.dart';
import 'package:sql_flutter3/util/databasehelper.dart';

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) => MaterialApp(
        title: 'Todo',
        home: MainTodo(),
      );
}

class MainTodo extends StatefulWidget {
  _MainTodo createState() => _MainTodo();
}

class _MainTodo extends State<MainTodo> {
  TextEditingController textController = TextEditingController();

  List<Todo> todoList = new List();

  void initState() {
    super.initState();
    DatabaseHelper.instance.getTodo().then((value) {
      setState(() {
        value.forEach((element) {
          todoList.add(Todo(
              id: element['id'],
              title: element['title'],
              status: element['status'] == 0 ? false : true));
        });
      });
    });
  }

  void _addTodo() async {
    String input = textController.text;
    if (input != null) {
      var id = await DatabaseHelper.instance
          .addTodo(Todo(title: input, status: false));

      setState(() {
        todoList.insert(0, Todo(id: id, title: input, status: false));
        textController.clear();
      });
    }
  }

  void _updateTodo(int index) async {
    await DatabaseHelper.instance.updateTodo(Todo(
        id: todoList[index].getId(),
        title: todoList[index].getTitle(),
        status: !todoList[index].getStatus()));
    setState(() {
      todoList[index] = Todo(
          id: todoList[index].getId(),
          title: todoList[index].getTitle(),
          status: !todoList[index].getStatus());
    });
  }

  void _deleteTodo(int index) async {
    await DatabaseHelper.instance.deleteTodo(todoList[index].getId());
    setState(() {
      todoList.removeAt(index);
    });
  }

  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Todo App'),
        ),
        body: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              AddTodo(
                textController: textController,
                addTodo: () {
                  setState(() {
                    _addTodo();
                  });
                },
              ),
              Expanded(child: todoList.isEmpty ? Container() : _buildList()),
            ],
          ),
        ),
      );

  Widget _buildList() {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        if (index == todoList.length) return null;
        return ListItems(
          todo: todoList[index],
          updateTodo: () {
            setState(() {
              _updateTodo(index);
            });
          },
          deleteTodo: () {
            setState(() {
              _deleteTodo(index);
            });
          },
        );
      },
    );
  }
}
