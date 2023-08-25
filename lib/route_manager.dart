import 'package:flutter/material.dart';
import 'package:flutter_state_management/add_todo_page.dart';
import 'package:flutter_state_management/home_page.dart';
import 'package:flutter_state_management/not_found_page.dart';
import 'package:flutter_state_management/routes.dart';

class RouteManager {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.home:
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
          settings: routeSettings,
        );
      case Routes.addTodo:
        return MaterialPageRoute(
          builder: (_) => AddTodoPage(),
          settings: routeSettings,
        );
      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => const NotFoundPage(),
    );
  }
}
