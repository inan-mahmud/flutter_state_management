import 'package:flutter/material.dart';
import 'package:flutter_state_management/src/core/di/locator.dart';
import 'package:flutter_state_management/src/core/route/route_manager.dart';
import 'package:flutter_state_management/src/core/route/routes.dart';
import 'package:flutter_state_management/src/features/todo/ui/controllers/todos_controller.dart';
import 'package:flutter_state_management/src/features/todo/ui/provider/todo_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
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
      todoController: TodosController(
        fetchTodosByCategoryUseCase: locator(),
        addTodoByCategoryUseCase: locator(),
        updateTodoUseCase: locator(),
      ),
      child: const MaterialApp(
        title: 'Todo App',
        onGenerateRoute: RouteManager.generateRoute,
        initialRoute: Routes.home,
      ),
    );
  }
}
