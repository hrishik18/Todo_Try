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
  int countOfTodos = 2;

  @override
  void initState() {
    super.initState();
    setcounter();
  }

  setcounter()async {
          final prefs = await SharedPreferences.getInstance();
          setState(() {
            countOfTodos = prefs.getInt('counter') ?? 0;
          });
    
  }
  addTodo(Todo todostr, bool isCompleted) async {
    //final todo = Todo(title: todostr);
    // prefs.setString(index.toString(), todostr.title);
    // prefs.setBool(index.toString(), isCompleted);
    // List<String> storinglist =
    //     todos.map((item) => json.encode(item.toMap())).toList();
    final prefs = await SharedPreferences.getInstance();
    String jsonString = json.encode(todostr.toJson());
    prefs.setString("${countOfTodos}", jsonString);
    await prefs.setInt('counter', countOfTodos);

    prefs.setString("${countOfTodos}_title", todostr.title);
    prefs.setBool("${countOfTodos}_compl", false);

    setState(() {
      //todos.add(todostr);
      countOfTodos++;
          prefs.setInt('counter', countOfTodos);

    });
    //TODO: print todos and check for pref if stored
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
          itemCount: countOfTodos,
          itemBuilder: (BuildContext context, int index) {
            return Todolistitem(index);
          }),
    );
  }
}

class Todolistitem extends StatefulWidget {
  const Todolistitem(this.index, {Key? key}) : super(key: key);
  final int index;
  @override
  _TodolistitemState createState() => _TodolistitemState();
}

class _TodolistitemState extends State<Todolistitem> {
  bool valuesecond = false;
  String st = "";
  Todo? todo;
  SharedPreferences? prefs;

  giveval(bool? b) async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      valuesecond = b!;
    });
    prefs!.setBool("${widget.index}_compl", b!);
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  getData() async {
    prefs = await SharedPreferences.getInstance();
    debugPrint("Inside get data");
    setState(() {
      // valuesecond = prefs!.getBool(widget.index.toString() + "_compl")!;
      // st = prefs!.getString(widget.index.toString() + "_title")!;
       String st = prefs!.getString(widget.index.toString())!;
      todo = Todo.fromJson(st);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: const Icon(Icons.list),
        trailing: Checkbox(value: valuesecond, onChanged: giveval),
        //title: Text(widget.todo.title));
        title: Text(st));
  }
}

class Additem extends StatelessWidget {
  const Additem({Key? key, required title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
