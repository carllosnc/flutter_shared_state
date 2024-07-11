import 'package:flutter/material.dart';
import '/modules/counter/counter_state.dart';
import '/modules/todo_list/todo_list_state.dart';
import '/modules/async_todo_list/async_todo_list_state.dart';
import '/modules/sqlite/database.dart';

/// A mixin that provides shared state management for Flutter widgets.
/// This mixin is intended to be used with `State` classes of `StatefulWidget`.
mixin SharedState<T extends StatefulWidget> on State<T> {
  /// Initializes the state and sets up a listener on the global state.
  /// The listener calls the `action` method whenever the state changes.
  @override
  void initState() {
    super.initState();
    counter.addListener(action);
    todoList.addListener(action);
    asyncTodoList.addListener(action);
    database.addListener(action);
  }

  /// Disposes the state and removes the listener from the global state
  /// to prevent memory leaks.
  @override
  void dispose() {
    super.dispose();
    counter.removeListener(action);
    todoList.removeListener(action);
    asyncTodoList.removeListener(action);
    database.removeListener(action);
  }

  /// This method is called whenever the counter changes.
  /// It triggers a rebuild of the widget by calling `setState`.
  void action() {
    setState(() {});
  }
}
