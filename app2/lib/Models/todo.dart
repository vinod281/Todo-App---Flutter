class Todo {
  String id;
  String title;
  bool isDone;

  Todo({
    required this.id,
    required this.title,
    this.isDone = false,
  });

  void isToggleDone() {
    isDone = !isDone;
  }

  static List<Todo> todoList() {
    return [
      Todo(
        id: '1',
        title: 'Learn Flutter',
      ),
      Todo(
        id: '2',
        title: 'Learn Dart',
        isDone: true,
      ),
      Todo(
        id: '3',
        title: 'Learn Firebase',
      ),
    ];
  }
}
