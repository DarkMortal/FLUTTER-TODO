import 'package:flutter/material.dart';
import 'package:todolistapp/widgets/popMessage.dart';
import 'package:todolistapp/widgets/todo_item.dart';
import 'package:todolistapp/models/todo.dart';
import 'package:todolistapp/models/sharedPrefHelper.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // const Home({super.key});
  List<ToDo> todosList = [];
  bool isDark = false;
  final _todoController = TextEditingController();

  void taskInit() async {
    todosList = await SharedPreferencesHelper.getTasks();
    isDark = await SharedPreferencesHelper.getTheme();

    setState(() {
      // pass
    });
  }

  @override
  void initState() {
    super.initState();
    taskInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: Stack(
        children: [
          Container(
            color: (this.isDark)
                ? const Color.fromRGBO(28, 35, 49, 1)
                : const Color.fromRGBO(236, 239, 244, 1),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
                Text(
                  (todosList.isEmpty)
                      ? "No tasks scheduled for today"
                      : "Showing all tasks",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: (this.isDark) ? Colors.white : Colors.black87,
                  ),
                ),
                (todosList.isEmpty)
                    ? Padding(
                        padding: const EdgeInsets.only(top: 100.0),
                        child: Center(
                            child: Icon(
                          Icons.alarm_add_rounded,
                          size: 40.0,
                          color: (this.isDark)
                              ? Colors.white
                              : const Color.fromRGBO(28, 35, 49, 1),
                        )))
                    : Expanded(
                        child: ListView(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            for (ToDo todoitem in todosList)
                              TodoItem(
                                isDark: this.isDark,
                                todo: todoitem,
                                onTodoChanged: _handleTodoChange,
                                onDeleteItem: _handleTodoDelete,
                                onEditHandler: _handleTodoEdit,
                              ),
                            const SizedBox(
                              height: 100,
                            )
                          ],
                        ),
                      )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(
                      bottom: 20,
                      right: 20,
                      left: 20,
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white, // theme add
                      boxShadow: [
                        BoxShadow(
                            color: (this.isDark)
                                ? Colors.black
                                : Colors.grey, // theme add
                            offset: const Offset(0.0, 0.0),
                            blurRadius: 10.0,
                            spreadRadius: 0.0)
                      ],
                      borderRadius: BorderRadius.circular((10)),
                    ),
                    child: TextField(
                      controller: _todoController,
                      style: const TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                        hintText: "Add a new task",
                        hintStyle: TextStyle(color: Colors.black), // theme add
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 20, right: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      _addTodoItem(_todoController.text, context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade800,
                      minimumSize: const Size(60, 60),
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: const Icon(Icons.add, color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _addTodoItem(String todo, BuildContext context) {
    String str = todo.trim();
    if (str == "") {
      showMessage(context, "Please Enter some text", this.isDark);
    } else {
      bool isPresent = false;
      for (ToDo t in todosList) {
        isPresent = (t.todoText == str);
        if (isPresent) break;
      }
      if (isPresent)
        showMessage(context, "Task already present", this.isDark);
      else {
        setState(() {
          todosList.add(ToDo(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            todoText: str,
          ));
        });
        SharedPreferencesHelper.saveTasks(todosList);
      }
      _todoController.clear();
    }
  }

  void _handleTodoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
    SharedPreferencesHelper.saveTasks(todosList);
  }

  void _handleTodoEdit(String id) {
    editModule(
            context,
            todosList.firstWhere((element) => element.id == id).todoText!,
            isDark)
        .then((value) {
      if (value != null) {
        setState(() {
          todosList[todosList.indexWhere((element) => element.id == id)]
              .todoText = value;
        });
        SharedPreferencesHelper.saveTasks(todosList);
      }
    });
  }

  void _handleTodoDelete(String id) {
    confirm(context, "Are you sure you want to delete this task?", this.isDark)
        .then((value) {
      if (value)
        setState(() {
          todosList.removeWhere((element) => element.id == id);
          SharedPreferencesHelper.saveTasks(todosList);
        });
    });
  }

  AppBar _buildAppbar() {
    return AppBar(
      backgroundColor: (this.isDark)
          ? const Color.fromRGBO(28, 35, 49, 1)
          : const Color.fromRGBO(236, 239, 244, 1),
      elevation: 0,
      scrolledUnderElevation: 0.0,
      title: Text(
        "Todos App",
        style: TextStyle(
            color: (this.isDark) ? Colors.white : Colors.black87,
            fontWeight: FontWeight.w500),
      ),
      actions: [
        Theme(
            data: Theme.of(context).copyWith(
              iconTheme: Theme.of(context).iconTheme,
              textTheme: Theme.of(context).textTheme,
            ),
            child: Switch.adaptive(
                value: isDark,
                activeColor: Colors.blue.withOpacity(0.4),
                activeTrackColor: Colors.blueAccent,
                inactiveThumbColor: Colors.blueGrey,
                inactiveTrackColor: Colors.blueGrey.withOpacity(0.4),
                onChanged: (bool x) {
                  setState(() {
                    this.isDark = x;
                  });
                  SharedPreferencesHelper.storeTheme(x);
                }))
      ],
    );
  }
}
