import 'package:flutter/material.dart';
import '/shared/shared_state.dart';
import 'increment_button.dart';
import 'decrement_button.dart';

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
            const IncrementButton(),
            const SizedBox(width: 10),
            Text(
              '${counter.value}',
            ),
            const SizedBox(width: 10),
            const DecrementButton(),
          ],
        ),
      ),
    );
  }
}
