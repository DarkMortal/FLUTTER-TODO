import 'package:flutter/material.dart';
import 'package:todolistapp/models/todo.dart';

class TodoItem extends StatelessWidget {
  // const TodoItem({super.key});

  final ToDo todo;
  final onTodoChanged;
  final onDeleteItem;

  const TodoItem({
    Key? key,
    required this.todo,
    required this.onTodoChanged,
    required this.onDeleteItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        onTap: () {
          onTodoChanged(todo);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        tileColor: Colors.white,
        leading: Icon(
            todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
            color: Colors.blue.shade800),
        title: Text(
          todo.todoText.toString(),
          style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
              decoration: todo.isDone ? TextDecoration.lineThrough : null),
        ),
        trailing: Container(
          height: 35,
          width: 35,
          decoration: BoxDecoration(
              color: Colors.red.shade400,
              borderRadius: BorderRadius.circular(5)),
          child: IconButton(
            icon: const Icon(Icons.delete),
            iconSize: 18,
            color: Colors.white,
            onPressed: () {
              onDeleteItem(todo.id);
            },
          ),
        ),
      ),
    );
  }
}
