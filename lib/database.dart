import 'package:sqflite/sqflite.dart';
import 'dart:async';

class Task {
  late String name;

  Task(this.name);

  Map<String, dynamic> toMap() {
    return {
      "name": name,
    };
  }

  Task.fromMap(Map<String, dynamic> map) {
    name = map['name'];
  }
}

class TaskDatabase {
  //nombre
  late Database _db;
  //metodo asincrono que inicializa la base de datos
  initDB() async {
    //nombre de database, version del script,
    _db = await openDatabase('my_db.db', version: 1,
        onCreate: (Database _db, int version) {
      _db.execute(
          "CREATE TABLE tasks (id INTEGER PRIMARY KEY, name TEXT NOT NULL)");
    });
    print('db inicializada');
  }

  insert(Task task) async {
    //se puede usar para escribir consulta sql
    //_db.rawInsert("sql")
    //se declara nombre de tabla , y el metodo map para recorrerla
    _db.insert("tasks", task.toMap());
  }

  //obtener tareas

  Future<List<Task>?> getAllTasks() async {
    //consulta de tabla
    List<Map<String, dynamic>> results = await _db.query("tasks");
    if (results.length > 0) {
      var res = results.map((map) => Task.fromMap(map)).toList();
      return res;
    }
    return null;
  }
}
