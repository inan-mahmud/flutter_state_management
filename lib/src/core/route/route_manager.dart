import 'package:flutter/material.dart';
import 'package:flutter_state_management/add_todo_page.dart';
import 'package:flutter_state_management/home_page.dart';
import 'package:flutter_state_management/src/core/route/not_found_page.dart';
import 'package:flutter_state_management/src/core/route/routes.dart';
import 'package:flutter_state_management/src/features/auth/sign_in/ui/sign_in_page.dart';
import 'package:flutter_state_management/src/features/auth/sign_up/ui/sign_up_page.dart';
import 'package:flutter_state_management/src/features/todo/tasks/ui/tasks_page.dart';
import 'package:flutter_state_management/src/features/user_profile/ui/user_profile_page.dart';

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
      case Routes.signIn:
        return MaterialPageRoute(
          builder: (_) => const SignInPage(),
          settings: routeSettings,
        );
      case Routes.signUp:
        return MaterialPageRoute(
          builder: (_) => const SignUpPage(),
          settings: routeSettings,
        );
      case Routes.tasks:
        return MaterialPageRoute(
          builder: (_) => const TasksPage(),
          settings: routeSettings,
        );
      case Routes.userProfile:
        return MaterialPageRoute(
          builder: (_) => const UserProfilePage(),
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
