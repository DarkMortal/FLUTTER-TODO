import 'package:flutter/material.dart';
import 'package:todolistapp/models/todo.dart';

class TodoItem extends StatelessWidget {
  // const TodoItem({super.key});

  final ToDo todo;
  final onTodoChanged;
  final onDeleteItem;
  final onEditHandler;
  final bool isDark;

  const TodoItem({
    Key? key,
    required this.isDark,
    required this.todo,
    required this.onTodoChanged,
    required this.onDeleteItem,
    required this.onEditHandler,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: (isDark) ? const Color.fromRGBO(23, 31, 46, 1) : Colors.white,
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
          todo.todoText!,
          style: TextStyle(
              fontSize: 16,
              color: (isDark) ? Colors.white : Colors.black87,
              decoration: todo.isDone ? TextDecoration.lineThrough : null,
              decorationColor: (isDark) ? Colors.white : Colors.black87
            ),
        ),
        trailing: Wrap(
            spacing: 10, // space between two icons
            children: [
              Container(
                  decoration: BoxDecoration(
                      color: Colors.blue.shade600,
                      borderRadius: BorderRadius.circular(5)),
                  height: 35,
                  width: 35,
                  child: IconButton(
                    icon: const Icon(Icons.edit),
                    iconSize: 18,
                    color: Colors.white,
                    onPressed: () {
                      onEditHandler(todo.id);
                    },
                  )),
              Container(
                  decoration: BoxDecoration(
                      color: Colors.red.shade400,
                      borderRadius: BorderRadius.circular(5)),
                  height: 35,
                  width: 35,
                  child: IconButton(
                    icon: const Icon(Icons.delete),
                    iconSize: 18,
                    color: Colors.white,
                    onPressed: () {
                      onDeleteItem(todo.id);
                    },
                  )),
            ]),
      ),
    );
  }
}
