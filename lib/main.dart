import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_module.dart';
import 'app_widget.dart';

void main() async {
    WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  runApp(
    ModularApp(
      module: AppModule(sharedPreferences: sharedPreferences),
      child: const AppWidget(),
    ),
  );
}
