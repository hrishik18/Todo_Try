import 'dart:convert';

class Todo {
  Todo({required this.title, required this.iscompl});
  String title;
  bool iscompl;

  Object? toMap() {}

  Map<String, dynamic> toJson() =>
      <String, dynamic>{"title": title, "iscompl": iscompl};

  static Todo fromJson(String s) {
    var d = jsonDecode(s);
    Todo t = Todo(title: d["title"], iscompl: d["iscompl"]);
    return t;
  }
}
