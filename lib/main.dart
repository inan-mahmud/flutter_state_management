import 'package:flutter/material.dart';
import 'package:flutter_state_management/src/core/route/route_manager.dart';
import 'package:flutter_state_management/src/core/route/routes.dart';
import 'package:flutter_state_management/todo_notifier.dart';
import 'package:flutter_state_management/todo_provider.dart';

Future<void> main() async {

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return TodoProvider(
      todoNotifier: TodoNotifier(),
      child: const MaterialApp(
        title: 'Todo App',
        onGenerateRoute: RouteManager.generateRoute,
        initialRoute: Routes.home,
      ),
    );
  }
}
