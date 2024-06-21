import 'dart:math';

import 'package:flutter/material.dart';

class Todo {
  final int id;
  final String description;
  bool done;

  Todo({
    required this.description,
    required this.done,
    required this.id,
  });
}

class _TodoList extends ChangeNotifier {
  final List<Todo> todos = [];

  void addTodo({
    required String description,
    required bool done,
  }) {
    todos.add(
      Todo(
        description: description,
        done: done,
        id: randomId,
      ),
    );

    notifyListeners();
  }

  void removeTodo(int id) {
    todos.removeWhere((element) => element.id == id);

    notifyListeners();
  }

  void checkTodo(int id, bool done) {
    todos.firstWhere((element) => element.id == id).done = done;

    notifyListeners();
  }

  int get randomId => Random().nextInt(100000) + 1;
}

// ignore: library_private_types_in_public_api
_TodoList todoList = _TodoList();
