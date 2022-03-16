class Todo {
  Todo({required this.title, required this.iscompl});
  String title;
  bool iscompl;

  Object? toMap() {}

  Map<String, dynamic> toJson() =>
      <String, dynamic>{"title": title, "iscompl": iscompl};
}
