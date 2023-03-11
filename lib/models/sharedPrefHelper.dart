import 'package:shared_preferences/shared_preferences.dart';
import 'package:todolistapp/models/todo.dart';

// Factory constructors:
// https://stackoverflow.com/questions/53886304/understanding-factory-constructor-code-example-dart
// https://stackoverflow.com/questions/52299304/dart-advantage-of-a-factory-constructor-identifier

class SharedPreferencesHelper {
  static final SharedPreferencesHelper _instance =
      SharedPreferencesHelper._ctor();

  factory SharedPreferencesHelper() {
    return _instance;
  }

  SharedPreferencesHelper._ctor();

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static late SharedPreferences _prefs;

  static void saveTasks(List<ToDo> tasks) async {
    await init();
    List<String> str = [];
    for (ToDo task in tasks) str.add(serialize(task));
    _prefs.setStringList('tasks', str);
  }

  static Future<List<ToDo>> getTasks() async {
    await  init();
    List<ToDo> tasks = [];
    List<String>? str = _prefs.getStringList('tasks');
    if (str == null) return tasks;
    for (String s in str) tasks.add(deSerialize(s));
    return tasks;
  }

  static Future<bool> getTheme() async {
    await init();
    bool? b = _prefs.getBool("theme");
    return (b == null) ? false : b;
  }

  static void storeTheme(bool x) async {
    await init();
    _prefs.setBool("theme", x);
  }
}
