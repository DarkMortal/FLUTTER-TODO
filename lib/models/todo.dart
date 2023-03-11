class ToDo {
  String? id;
  String? todoText;
  late bool isDone;

  ToDo({required this.id, required this.todoText, this.isDone = false});

  /*static List<ToDo> todolist() {
    return [
      ToDo(id: '01', todoText: 'Morning Exercise', isDone: true),
      ToDo(id: '02', todoText: 'Buy Groceries', isDone: true),
      ToDo(id: '03', todoText: 'Check emails', isDone: false),
      ToDo(id: '04', todoText: 'Learn Flutter', isDone: false),
      ToDo(id: '05', todoText: 'Take rest', isDone: false),
    ];
  }*/
}

String serialize(ToDo t) {
  return '${t.id} ${t.todoText} ${t.isDone.toString()}';
}

ToDo deSerialize(String s) {
  List<String> str = s.split(' ');
  String id = str[0];
  String bool = str[str.length - 1];
  String text = s.substring(id.length + 1, s.length - bool.length - 1);
  return ToDo(id: id, todoText: text, isDone: bool.toLowerCase() == 'true');
}
