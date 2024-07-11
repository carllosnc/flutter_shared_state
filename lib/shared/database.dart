import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBTodo {
  int? id;
  String title;
  String description;
  String isDone = 'false';

  DBTodo({
    this.id,
    required this.title,
    required this.description,
    required this.isDone,
  });

  DBTodo.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        isDone = json['isDone'],
        description = json['description'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'isDone': isDone,
        'description': description,
      };

  static asSQL() {
    return '''
      CREATE TABLE todo (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        isDone INTEGER NOT NULL,
        title TEXT NOT NULL,
        description TEXT
      );
    ''';
  }
}

class _Database extends ChangeNotifier {
  late Future<Database> _database;

  List<DBTodo> todos = [];
  bool isLoading = false;

  init() async {
    _database = openDatabase(
      join(
        await getDatabasesPath(),
        'flutter.db',
      ),
      onCreate: (db, version) async {
        await db.execute(DBTodo.asSQL());
      },
      version: 1,
    );
  }

  Future<void> createTodo(DBTodo todo) async {
    isLoading = true;

    var db = await _database;
    await db.insert('todo', todo.toJson());
    await getTodos();

    isLoading = false;
    notifyListeners();
  }

  Future<void> updateTodo(DBTodo todo) async {
    isLoading = true;

    var db = await _database;
    await db.update('todo', todo.toJson(), where: 'id = ?', whereArgs: [todo.id]);
    await getTodos();

    isLoading = false;
    notifyListeners();
  }

  Future<void> deleteTodo(DBTodo todo) async {
    isLoading = true;

    var db = await _database;
    await db.delete('todo', where: 'id = ?', whereArgs: [todo.id]);
    await getTodos();

    isLoading = false;
    notifyListeners();
  }

  Future<void> getTodos() async {
    isLoading = true;

    var db = await _database;
    var todos = await db.query('todo');
    this.todos = todos.map((e) => DBTodo.fromJson(e)).toList().reversed.toList();

    isLoading = false;
    notifyListeners();
  }
}

var database = _Database();
