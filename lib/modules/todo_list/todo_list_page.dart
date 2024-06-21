import 'package:flutter/material.dart';
import '/shared/shared_state.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> with SharedState {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          todoList.addTodo(
            description: 'New Todo: ${todoList.randomId}',
            done: false,
          );
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text('Todo List - Total: ${todoList.todos.length}'),
      ),
      body: ListView.builder(
        itemCount: todoList.todos.length,
        itemBuilder: (context, index) {
          Todo todo = todoList.todos[index];

          return ListTile(
            title: Text(
              todo.description,
              style: TextStyle(
                fontSize: 20,
                color: todo.done ? Colors.red : Colors.black,
                decoration: todo.done ? TextDecoration.lineThrough : null,
              ),
            ),
            leading: IconButton(
              onPressed: () {
                todoList.checkTodo(todo.id, !todo.done);
              },
              icon: Icon(
                todo.done ? Icons.check_box : Icons.check_box_outline_blank,
              ),
            ),
            trailing: IconButton(
              onPressed: () {
                todoList.removeTodo(todo.id);
              },
              icon: const Icon(Icons.delete),
            ),
          );
        },
      ),
    );
  }
}
