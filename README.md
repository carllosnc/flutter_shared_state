# Flutter Shared State

>Sharing state between widgets usgin ChangeNotifier and Mixin

**ChangeNotifier:** is a class that allows you to share state between widgets. It provides a way to notify listeners when the state changes.

**Mixin:** is a way to share state between widgets. It allows you to define a set of methods that can be used by multiple widgets.

With these two resources, we can create a shared state that can be used by multiple widgets.

## 01 - Create a ChangeNotifier

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

## 02 - Create states extending ChangeNotifier

States are simple classes that extend `ChangeNotifier`. Our classe will be private and will provide
only one instance. Check the example below:

```dart
import 'package:flutter/material.dart';

class _Counter extends ChangeNotifier {
  int value = 0;

  void increment() {
    value++;
    notifyListeners();
  }

  void decrement() {
    value--;
    notifyListeners();
  }
}

// ignore: library_private_types_in_public_api
_Counter counter = _Counter();
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

## 04 - Testing a shared state

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

### Examples

- [**Counter**](https://github.com/carllosnc/flutter_shared_state/tree/master/lib/modules/counter)
- [**Todo list**](https://github.com/carllosnc/flutter_shared_state/tree/master/lib/modules/todo_list)

---

Carlos Costa @ 2024
