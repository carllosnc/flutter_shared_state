import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_shared_state/modules/todo_list/todo_list_state.dart';

void main() {
  test('check todo: adding items ', () {
    expect(todoList.todos.length, 0);

    todoList.addTodo(
      description: 'First Todo',
      done: false,
    );
    todoList.addTodo(
      description: 'Second Todo',
      done: true,
    );
    todoList.addTodo(
      description: 'Third Todo',
      done: false,
    );

    expect(todoList.todos.length, 3);

    expect(todoList.todos[0].description, 'First Todo');
    expect(todoList.todos[0].done, false);

    expect(todoList.todos[1].description, 'Second Todo');
    expect(todoList.todos[1].done, true);

    expect(todoList.todos[2].description, 'Third Todo');
    expect(todoList.todos[2].done, false);
  });

  test('check todo: marking items as done', () {
    todoList.addTodo(
      description: 'Unchecked Todo',
      done: false,
    );

    todoList.checkTodo(todoList.todos[0].id, true);
    expect(todoList.todos[0].done, true);

    todoList.checkTodo(todoList.todos[0].id, false);
    expect(todoList.todos[0].done, false);
  });

  test('check todo: removing items', () {
    todoList.removeTodo(todoList.todos[0].id);
    todoList.removeTodo(todoList.todos[1].id);

    expect(todoList.todos.length, 2);
  });
}
