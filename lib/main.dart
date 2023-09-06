import 'package:flutter/material.dart';
import 'package:flutter_state_management/src/core/di/locator.dart';
import 'package:flutter_state_management/src/core/route/route_manager.dart';
import 'package:flutter_state_management/src/core/route/routes.dart';
import 'package:flutter_state_management/src/core/service/database/database_service.dart';

late DatabaseService databaseService;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //databaseService = await DatabaseService.create();
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
    return MaterialApp(
      title: 'Todo App',
      onGenerateRoute: RouteManager().generateRoute,
      initialRoute: Routes.home,
    );
  }
}
