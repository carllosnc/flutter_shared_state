# Flutter Shared State

[![flutter_shared_state](https://github.com/carllosnc/flutter_shared_state/actions/workflows/dart.yml/badge.svg)](https://github.com/carllosnc/flutter_shared_state/actions/workflows/dart.yml)

>A simple way to share state between widgets using ChangeNotifier to reactivity and Mixins states.

**ChangeNotifier:** is a class that provides a simple way to manage state and notify listeners about changes.

**Mixin:** is a class used to share reusable code across multiple classes. Mixins allow a class to inherit methods and properties from multiple sources.

**Goals:**

- *Shareable*: easily accessible from multiple widgets.
- *Isolated*: no need to worry about ui.
- *Testable*: easy to test because it's isolated.
- *Reusable*: can be used in multiple widgets easily.
- *No dependency*: all resources are provided by dart/flutter.
- *Controlled*: easy to control the state and side effects

### Examples

- [**Counter**](https://github.com/carllosnc/flutter_shared_state/tree/master/lib/modules/counter)
- [**Todo list**](https://github.com/carllosnc/flutter_shared_state/tree/master/lib/modules/todo_list)
- [**Async todo list**](https://github.com/carllosnc/flutter_shared_state/tree/master/lib/modules/async_todo_list)
- [**Todo list with sqlite**](https://github.com/carllosnc/flutter_shared_state/tree/master/lib/modules/sqlite)

## 01 - Creating the mixin (state container)

This mixin will work like a container for all states, all "state objects" will registred here.

```dart
import 'package:flutter/material.dart';
import 'counter.dart';
import 'todo_list.dart';

export 'counter.dart';
export 'todo_list.dart';

mixin SharedState<T extends StatefulWidget> on State<T> {
  /// Initializes the state and sets up a listener on the global state.
  /// The listener calls the `action` method whenever the state changes.
  @override
  void initState() {
    super.initState();
    counter.addListener(action);
    todoList.addListener(action);
  }

  /// Disposes the state and removes the listener from the global state
  /// to prevent memory leaks.
  @override
  void dispose() {
    super.dispose();
    counter.removeListener(action);
    todoList.removeListener(action);
  }

  /// This method is called whenever the counter changes.
  /// It triggers a rebuild of the widget by calling `setState`.
  void action() {
    setState(() {});
  }
}
```

## 02 - Creating states that extend ChangeNotifier (state object)

States are single objects provided by classes that extends `ChangeNotifier`.

```dart
import 'package:flutter/material.dart';

class _Counter extends ChangeNotifier {
  int value = 0;

  void increment() {
    value++;

    //triggering a side effect
    notifyListeners();
  }

  void decrement() {
    value--;

    //triggering a side effect
    notifyListeners();
  }
}

//global variable
var counter = _Counter();
```

## 03 - Using SharedState mixin

We can use the `SharedState` mixin to share the state between widgets.

```dart
import 'package:flutter/material.dart';
import '/shared/shared_state.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> with SharedState {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter'),
      ),
      body: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton(
              onPressed: counter.increment,
              child: Text('Increment ${counter.value}'),
            )
          ],
        ),
      ),
    );
  }
}
```

## 04 - Testing the state object

Our state is completely isolated from the widgets and can be tested easily.

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_shared_state/shared/shared_state.dart';

void main() {
  test('check counter state', () {
    expect(counter.value, 0);
    counter.increment();
    expect(counter.value, 1);
    counter.increment();
    expect(counter.value, 2);
    counter.decrement();
    expect(counter.value, 1);
    counter.decrement();
    expect(counter.value, 0);
  });
}
```

Carlos Costa @ 2024
