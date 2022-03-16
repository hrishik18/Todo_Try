import 'dart:html';

import 'package:flutter/material.dart';
import 'package:random/todo.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-list',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const Todolist(),
    );
  }
}

//client id - 87867891558-p8khtfmadd47rn6civs1ravc32dqe80f.apps.googleusercontent.com
class Todolist extends StatefulWidget {
  const Todolist({Key? key}) : super(key: key);

  @override
  _TodolistState createState() => _TodolistState();
}

class _TodolistState extends State<Todolist> {
  final controller = TextEditingController();
  late SharedPreferences prefs;
  //final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  List<Todo> todos = [];
  int index = 0;

  @override
  void initState() {
    initializepref();
    super.initState();
  }

  initializepref() async {
    // Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();
  }

  addTodo(Todo todostr, bool isCompleted) async {
    //final todo = Todo(title: todostr);
    // prefs.setString(index.toString(), todostr.title);
    // prefs.setBool(index.toString(), isCompleted);
    // List<String> storinglist =
    //     todos.map((item) => json.encode(item.toMap())).toList();
    String jsonString =json.encode(todostr.toJson());
    todos.add(todostr);
    controller.clear();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('To-Do List')),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Add item"),
                content: TextField(
                  controller: controller,
                  autofocus: true,
                ),
                actions: <Widget>[
                  TextButton(
                      child: const Text('Add'),
                      onPressed: () {
                        final todo =
                            Todo(title: controller.value.text, iscompl: false);
                        addTodo(todo, false);
                      }
                      //addTodo(controller.value.text, false),
                      ),
                ],
              );
            }),
      ),
      body: ListView.builder(
          itemCount: todos.length,
          itemBuilder: (BuildContext context, int index) {
            return Todolistitem(todo: todos[index]);
          }),
    );
  }
}

class Todolistitem extends StatefulWidget {
  const Todolistitem({Key? key, required this.todo}) : super(key: key);
  final Todo todo;
  @override
  _TodolistitemState createState() => _TodolistitemState();
}

class _TodolistitemState extends State<Todolistitem> {
  bool valuesecond = false;
  String st = "";
  int index = 0;

  giveval() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      valuesecond = prefs.getBool(index.toString())!;
      st = prefs.getString(index.toString())!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return ListTile(
          leading: const Icon(Icons.list),
          trailing: Checkbox(value: valuesecond, onChanged: giveval()),
          //title: Text(widget.todo.title));
          title: Text(st));
    });
  }
}

class Additem extends StatelessWidget {
  const Additem({Key? key, required title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
