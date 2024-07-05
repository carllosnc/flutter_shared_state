import 'dart:math';

import 'package:flutter/material.dart';

class AsyncTodo {
  final String description;
  bool done;
  final int id;
  bool isLoading = false;

  AsyncTodo({
    required this.description,
    required this.done,
    required this.id,
  });
}

class _AsyncTodoList extends ChangeNotifier {
  final List<AsyncTodo> todos = [];
  bool addLoading = false;
  bool removeLoading = false;

  setAddLoading(bool isLoading) {
    addLoading = isLoading;
    notifyListeners();
  }

  Future<void> addTodo({
    required String description,
    required bool done,
  }) {
    setAddLoading(true);

    return Future.delayed(const Duration(seconds: 1), () {
      todos.add(
        AsyncTodo(
          description: description,
          done: done,
          id: randomId,
        ),
      );

      setAddLoading(false);
      addLoading = false;
    });
  }

  Future<void> checkTodo(int id, bool done) async {
    todos.firstWhere((element) => element.id == id).isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));

    todos.firstWhere((element) => element.id == id).done = done;
    todos.firstWhere((element) => element.id == id).isLoading = false;
    notifyListeners();
  }

  Future<void> deleteTodo(int id) async {
    todos.firstWhere((element) => element.id == id).isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));

    todos.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  int get randomId => Random().nextInt(100000) + 1;
}

var asyncTodoList = _AsyncTodoList();
