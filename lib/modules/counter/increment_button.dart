import 'package:flutter/material.dart';
import '../../shared_state.dart';
import 'counter_state.dart';

class IncrementButton extends StatefulWidget {
  const IncrementButton({super.key});

  @override
  State<IncrementButton> createState() => _IncrementButtonState();
}

class _IncrementButtonState extends State<IncrementButton> with SharedState {
  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: counter.increment,
      child: Text('Increment ${counter.value}'),
    );
  }
}
