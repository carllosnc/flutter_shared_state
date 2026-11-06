# AI Agent Guide - Flutter Shared State

Welcome! This document provides context, architectural rules, and operational guidelines for AI coding assistants (such as Antigravity, Cursor, Claude Code, GitHub Copilot, etc.) working on this repository.

---

## 1. Project Overview & Philosophy

**flutter_shared_state** is a minimalist, dependency-free reference project demonstrating how to manage and share state between Flutter widgets using only Dart/Flutter built-ins:
- **`ChangeNotifier`**: Encapsulates state and business logic, emitting notifications via `notifyListeners()`.
- **`SharedState` Mixin**: Mixin on `State<T extends StatefulWidget>` that automatically subscribes to state objects on `initState` and unsubscribes on `dispose`, triggering `setState` upon notifications.

### Strict Architectural Boundaries (Guardrails)
> [!IMPORTANT]
> - **NEVER** introduce external state management packages (e.g., `flutter_bloc`, `provider`, `riverpod`, `get`, `mobx`, `signals`).
> - Keep state objects completely decoupled and isolated from Flutter UI dependencies (`BuildContext`, widgets) whenever possible.
> - Maintain 100% pass rate on `flutter analyze` and `flutter test`.

---

## 2. Project Structure

```text
flutter_shared_state/
├── .github/workflows/dart.yml     # GitHub Actions CI workflow
├── analysis_options.yaml          # Lint rules (flutter_lints)
├── pubspec.yaml                   # Dependencies and SDK constraints
├── lib/
│   ├── main.dart                  # Application entry point
│   ├── app.dart                   # MaterialApp root configuration
│   ├── shared_state.dart          # Central SharedState mixin (state registry)
│   └── modules/                   # Feature modules
│       ├── counter/               # Counter example (split widgets & state)
│       ├── todo_list/             # In-memory todo list
│       ├── async_todo_list/       # Async simulated state & loading flags
│       ├── sqlite/                # SQLite local persistence with sqflite
│       └── home/                  # Home navigation menu
└── test/
    ├── unit/                      # Isolated state unit tests
    └── widgets/                   # Widget integration & rendering tests
```

---

## 3. The Core Pattern

### A. State Definition (`<feature>_state.dart`)
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

// Global top-level instance
var counter = _Counter();
```

### B. State Registration (`lib/shared_state.dart`)
Whenever a new state is added, register it in `SharedState`:
```dart
mixin SharedState<T extends StatefulWidget> on State<T> {
  @override
  void initState() {
    super.initState();
    counter.addListener(action);
    newFeatureState.addListener(action); // Register listener
  }

  @override
  void dispose() {
    super.dispose();
    counter.removeListener(action);
    newFeatureState.removeListener(action); // Unregister listener
  }

  void action() {
    if (mounted) {
      setState(() {});
    }
  }
}
```

### C. Consuming in UI (`<feature>_page.dart`)
```dart
class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> with SharedState {
  @override
  Widget build(BuildContext context) {
    return Text('${counter.value}');
  }
}
```

---

## 4. How to Add a New Feature Module (Step-by-Step)

When asked to create a new module/feature, follow this workflow:

1. **Create State**:
   Create `lib/modules/<feature_name>/<feature_name>_state.dart` extending `ChangeNotifier`. Declare public getters/methods with explicit return types.
2. **Register in `SharedState`**:
   Import the state in `lib/shared_state.dart`, add it to `initState()` and `dispose()`.
3. **Create UI Page**:
   Create `lib/modules/<feature_name>/<feature_name>_page.dart` using `StatefulWidget with SharedState`. Add semantic `ValueKey`s for testability.
4. **Register in Home**:
   Add navigation item to `lib/modules/home/home_page.dart` if applicable.
5. **Write Unit Tests**:
   Add `test/unit/<feature_name>_state_test.dart` asserting state transitions directly on the state object.
6. **Write Widget Tests**:
   Add `test/widgets/<feature_name>_test.dart` verifying widget rendering and interaction using `tester.tap()` and `tester.pumpAndSettle()`.

---

## 5. Development & Verification Commands

Always run and verify these commands after making changes:

```bash
# 1. Format all code according to Dart guidelines
dart format .

# 2. Check for any formatting discrepancies (used by CI)
dart format --output=none --set-exit-if-changed .

# 3. Analyze for linter errors or warnings
flutter analyze

# 4. Run the entire test suite
flutter test
```

---

## 6. Code Style Guidelines for AI

- **Explicit Types**: Always annotate top-level functions, class methods, and return types (e.g., `void`, `Future<void>`, `int`).
- **Const Constructors**: Prefer `const` widgets and constructors wherever possible.
- **Keys in Widgets**: Use `const ValueKey('key_name')` on interactive elements and testable widgets.
- **No Unused Imports**: Remove any unused imports before finishing.
- **Defensive State in Widgets**: When triggering `setState` asynchronously or from listeners, check `if (mounted)` to prevent exceptions.
