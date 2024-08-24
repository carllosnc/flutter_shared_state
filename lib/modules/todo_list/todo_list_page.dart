import 'package:flutter/material.dart';
import '/shared_state.dart';
import 'todo_list_state.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> with SharedState {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const ValueKey('todo_list_page'),
      floatingActionButton: FloatingActionButton(
        key: const ValueKey('add_todo_button'),
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
      body: Builder(builder: (context) {
        if (todoList.todos.isEmpty) {
          return const Center(
            key: ValueKey('todo_list_empty_message'),
            child: Text('No Todos', style: TextStyle(fontSize: 20)),
          );
        }

        return ListView.builder(
          key: const ValueKey('todo_list_body'),
          itemCount: todoList.todos.length,
          itemBuilder: (context, index) {
            Todo todo = todoList.todos[index];

            return ListTile(
              key: ValueKey("todo_list_item_$index"),
              title: Text(
                todo.description,
                style: TextStyle(
                  fontSize: 20,
                  color: todo.done ? Colors.red : Colors.black,
                  decoration: todo.done ? TextDecoration.lineThrough : null,
                ),
              ),
              onTap: () {
                setDescription(context, (String description) {
                  todoList.setDescription(
                    todo.id,
                    description,
                  );
                });
              },
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
        );
      }),
    );
  }

  void setDescription(BuildContext context, Function(String description) updateAction) {
    final TextEditingController controller = TextEditingController();
    final formKey = GlobalKey<FormState>();

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Edit Todo'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: controller,
                    validator: (value) => (value == null || value.isEmpty) ? 'Description is required' : null,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                    ),
                    autofocus: true,
                  ),
                  const SizedBox(height: 20),
                  FilledButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        updateAction(controller.text);
                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text('Save'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
