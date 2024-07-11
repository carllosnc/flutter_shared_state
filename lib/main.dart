import 'package:flutter/material.dart';
import '/shared/shared_state.dart';

import 'app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  database.init();

  runApp(const App());
}
