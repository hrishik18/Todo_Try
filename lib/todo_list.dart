import 'package:flutter/material.dart';

import 'package:random/todo.dart';

typedef ToggleTodoCallback = void Function(Todo, bool);

class TodoList extends StatelessWidget {
  TodoList({required this.todos,required this.onTodoToggle});
  bool valuefirst = false;
  bool valuesecond = false;
  final List<Todo> todos;
  final ToggleTodoCallback onTodoToggle;

  Widget _buildItem(BuildContext context, int index) {
    final todo = todos[index];

    return CheckboxListTile(
      value: valuesecond,//add bool type
      title: Text(todo.title),
      onChanged: (bool? isChecked) {
      //  setState(() {
      //     valuesecond = value!;
      //   });
       onTodoToggle(todo, !valuesecond);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: _buildItem,
      itemCount: todos.length,
    );
  }
}
