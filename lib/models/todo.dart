class ToDo {
  String? id;
  String? todoText;
  late bool isDone;

  ToDo({required this.id, required this.todoText, this.isDone = false});

  static List<ToDo> todolist() {
    return [
      ToDo(id: '01', todoText: 'Morning Exercise', isDone: true),
      ToDo(id: '02', todoText: 'Buy Groceries', isDone: true),
      ToDo(id: '03', todoText: 'Check emails', isDone: false),
      ToDo(id: '04', todoText: 'Learn Flutter', isDone: false),
      ToDo(id: '05', todoText: 'Take rest', isDone: false),
    ];
  }
}
