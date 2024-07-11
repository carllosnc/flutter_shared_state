import 'package:flutter/material.dart';
import '../../shared_state.dart';
import 'counter_state.dart';

class DecrementButton extends StatefulWidget {
  const DecrementButton({super.key});

  @override
  State<DecrementButton> createState() => _DecrementButtonState();
}

class _DecrementButtonState extends State<DecrementButton> with SharedState {
  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: counter.decrement,
      child: Text('Decrement ${counter.value}'),
    );
  }
}
