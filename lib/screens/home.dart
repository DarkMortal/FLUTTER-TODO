import 'package:flutter/material.dart';
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
                ? Color.fromRGBO(28, 35, 49, 1)
                : Color.fromRGBO(236, 239, 244, 1),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
                Text(
                  (todosList.isEmpty)
                      ? "No tasks scheduled for today"
                      : "Showing all tasks:-",
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
                              : Color.fromRGBO(28, 35, 49, 1),
                        )))
                    : Expanded(
                        child: ListView(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            for (ToDo todoitem in todosList)
                              TodoItem(
                                todo: todoitem,
                                onTodoChanged: _handleTodoChange,
                                onDeleteItem: _handleTodoDelete,
                              ),
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
                      style: TextStyle(color: Colors.black),
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
                    ),
                    child: const Icon(Icons.add),
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
    if (todo == "") {
      showDialog(
          context: context,
          builder: (context) => Container(
                child: AlertDialog(
                    backgroundColor: (this.isDark)
                        ? Color.fromRGBO(28, 35, 49, 1)
                        : Color.fromRGBO(236, 239, 244, 1),
                    title: Text(
                      "Please Enter some text",
                      style: TextStyle(
                          color: (this.isDark) ? Colors.white : Colors.black),
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("OK"))
                    ]),
              ));
    } else {
      setState(() {
        todosList.add(ToDo(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          todoText: todo,
        ));
      });
      SharedPreferencesHelper.saveTasks(todosList);
      _todoController.clear();
    }
  }

  void _handleTodoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
    SharedPreferencesHelper.saveTasks(todosList);
  }

  void _handleTodoDelete(String id) {
    setState(() {
      todosList.removeWhere((element) => element.id == id);
      SharedPreferencesHelper.saveTasks(todosList);
    });
  }

  AppBar _buildAppbar() {
    return AppBar(
      backgroundColor:
          (this.isDark) ? Color.fromRGBO(23, 31, 46, 1) : Colors.grey.shade200,
      elevation: 0,
      title: Text(
        "Flutter Todo App",
        style: TextStyle(color: (this.isDark) ? Colors.white : Colors.black87),
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
