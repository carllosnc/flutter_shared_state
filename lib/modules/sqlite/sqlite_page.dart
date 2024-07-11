import 'dart:math';

import 'package:flutter/material.dart';
import '/shared/shared_state.dart';

class SqlitePage extends StatefulWidget {
  const SqlitePage({super.key});

  @override
  State<SqlitePage> createState() => _SqlitePageState();
}

class _SqlitePageState extends State<SqlitePage> with SharedState {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          DBTodo todo = DBTodo(
            isDone: 'false',
            title: 'Todo ${Random().nextInt(1000)}',
            description: 'Todo description',
          );

          database.createTodo(todo);
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('Sqlite Example'),
      ),
      body: Builder(builder: (context) {
        if (database.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (database.todos.isEmpty) {
          return const Center(
            child: Text(
              "Empty",
              style: TextStyle(fontSize: 35),
            ),
          );
        }

        return ListView.builder(
          itemCount: database.todos.length,
          itemBuilder: (context, index) {
            DBTodo todo = database.todos[index];
            return ListTile(
              title: Text('${todo.id}: ${todo.title}'),
              subtitle: Text(todo.description),
              leading: Checkbox(
                value: todo.isDone == 'true',
                onChanged: (value) async {
                  value == true //
                      ? todo.isDone = 'true'
                      : todo.isDone = 'false';

                  database.updateTodo(todo);
                },
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () async {
                  database.deleteTodo(todo);
                },
              ),
            );
          },
        );
      }),
    );
  }
}
