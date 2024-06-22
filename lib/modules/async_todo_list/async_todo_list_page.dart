import 'package:flutter/material.dart';
import '/shared/shared_state.dart';

class AsyncTodoListPage extends StatefulWidget {
  const AsyncTodoListPage({super.key});

  @override
  State<AsyncTodoListPage> createState() => AsyncTodoListPageState();
}

class AsyncTodoListPageState extends State<AsyncTodoListPage> with SharedState {
  createNewTodo() {
    if (asyncTodoList.addLoading) {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('A new todo is being created'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      asyncTodoList.addTodo(
        description: 'New Todo: ${asyncTodoList.randomId}',
        done: false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Async Todo List'),
        actions: [
          if (asyncTodoList.addLoading)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTodo,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: asyncTodoList.todos.length,
        itemBuilder: (context, index) {
          AsyncTodo todo = asyncTodoList.todos[index];

          return Opacity(
            opacity: todo.isLoading ? 0.5 : 1,
            child: ListTile(
              title: Text(
                todo.isLoading ? 'Loading...' : todo.description,
              ),
              leading: IconButton(
                onPressed: () {
                  if (todo.isLoading) return;
                  asyncTodoList.checkTodo(todo.id, !todo.done);
                },
                icon: Icon(todo.done ? Icons.check_box : Icons.check_box_outline_blank),
              ),
              trailing: IconButton(
                onPressed: () {
                  if (todo.isLoading) return;
                  asyncTodoList.deleteTodo(todo.id);
                },
                icon: const Icon(Icons.delete),
              ),
            ),
          );
        },
      ),
    );
  }
}
