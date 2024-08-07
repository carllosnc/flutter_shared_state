import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_shared_state/modules/counter/counter_state.dart';

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
