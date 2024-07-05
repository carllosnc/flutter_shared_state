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

var counter = _Counter();
