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
      ),
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
