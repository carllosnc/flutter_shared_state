import 'package:flutter_shared_state/shared/async_todo_list.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('check async todo: adding items ', () async {
    expect(asyncTodoList.todos.length, 0);

    await asyncTodoList.addTodo(
      description: 'First Todo',
      done: false,
    );

    await asyncTodoList.addTodo(
      description: 'Second Todo',
      done: true,
    );

    await asyncTodoList.addTodo(
      description: 'Third Todo',
      done: false,
    );

    expect(asyncTodoList.todos.length, 3);

    expect(asyncTodoList.todos[0].description, 'First Todo');
    expect(asyncTodoList.todos[0].done, false);

    expect(asyncTodoList.todos[1].description, 'Second Todo');
    expect(asyncTodoList.todos[1].done, true);

    expect(asyncTodoList.todos[2].description, 'Third Todo');
    expect(asyncTodoList.todos[2].done, false);
  });

  test('check async todo: marking items as done', () async {
    await asyncTodoList.addTodo(
      description: 'Unchecked Todo',
      done: false,
    );

    await asyncTodoList.checkTodo(asyncTodoList.todos[0].id, true);
    expect(asyncTodoList.todos[0].done, true);

    await asyncTodoList.checkTodo(asyncTodoList.todos[0].id, false);
    expect(asyncTodoList.todos[0].done, false);
  });

  test('check async todo: removing items', () async {
    await asyncTodoList.deleteTodo(asyncTodoList.todos[0].id);
    await asyncTodoList.deleteTodo(asyncTodoList.todos[1].id);

    expect(asyncTodoList.todos.length, 2);
  });
}
