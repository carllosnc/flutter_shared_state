import 'package:flutter/material.dart';
import '/modules/sqlite/database.dart';

import 'app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  database.init();

  runApp(const App());
}
