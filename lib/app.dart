import 'package:flutter/material.dart';
import 'modules/home/home_page.dart';
import 'modules/counter/counter_page.dart';
import 'modules/todo_list/todo_list_page.dart';
import 'modules/async_todo_list/async_todo_list_page.dart';
import 'modules/sqlite/sqlite_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Home(),
      routes: {
        '/counter': (context) => const CounterPage(),
        '/todo_list': (context) => const TodoListPage(),
        '/async_todo_list': (context) => const AsyncTodoListPage(),
        '/sqlite': (context) => const SqlitePage(),
      },
    );
  }
}
