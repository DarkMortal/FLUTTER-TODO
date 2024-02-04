import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showMessage(BuildContext context, String message, bool isDark) {
  if (Platform.isAndroid) {
    Fluttertoast.showToast(
      msg: message,
      fontSize: 18,
    );
  } else {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Message",
            style: TextStyle(color: (isDark) ? Colors.white : Colors.black)),
        backgroundColor: (isDark)
            ? const Color.fromRGBO(28, 35, 49, 1)
            : const Color.fromRGBO(236, 239, 244, 1),
        content: Text(message,
            style: TextStyle(color: (isDark) ? Colors.white : Colors.black)),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5))),
        actions: [
          TextButton(
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.blueAccent)),
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Ok', style: TextStyle(color: Colors.white))),
        ],
      ),
    );
  }
}

Future<bool> confirm(BuildContext context, String message, bool isDark) async {
  return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
            backgroundColor: (isDark)
                ? const Color.fromRGBO(28, 35, 49, 1)
                : const Color.fromRGBO(236, 239, 244, 1),
            title: Text("Confirm Dialog",
                style:
                    TextStyle(color: (isDark) ? Colors.white : Colors.black)),
            content: Text(message,
                style:
                    TextStyle(color: (isDark) ? Colors.white : Colors.black)),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5))),
            actions: [
              TextButton(
                  style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.blueAccent)),
                  onPressed: () => Navigator.of(context).pop(true),
                  child:
                      const Text('Yes', style: TextStyle(color: Colors.white))),
              TextButton(
                  style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.blueAccent)),
                  onPressed: () => Navigator.of(context).pop(false),
                  child:
                      const Text('No', style: TextStyle(color: Colors.white)))
            ],
          ));
}

Future<dynamic> editModule(
    BuildContext context, String task, bool isDark) async {
  final taskController = TextEditingController();
  taskController.text = task;
  return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
              backgroundColor: (isDark)
                  ? const Color.fromRGBO(28, 35, 49, 1)
                  : const Color.fromRGBO(236, 239, 244, 1),
              title: Text('Edit Task',
                  style:
                      TextStyle(color: (isDark) ? Colors.white : Colors.black)),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              content: TextField(
                controller: taskController,
                decoration: InputDecoration(
                  hintText: "Enter new task",
                  hintStyle:
                      TextStyle(color: (isDark) ? Colors.white : Colors.black),
                ),
                style: TextStyle(color: (isDark) ? Colors.white : Colors.black),
              ),
              actions: [
                TextButton(
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.blueAccent)),
                    onPressed: () {
                      if (taskController.text == "")
                        showMessage(context, "Please enter some text", isDark);
                      else
                        Navigator.of(context).pop(taskController.text);
                    },
                    child: const Text('Submit',
                        style: TextStyle(color: Colors.white)))
              ]));
}
