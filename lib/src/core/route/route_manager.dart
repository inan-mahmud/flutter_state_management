import 'package:flutter/material.dart';
import 'package:flutter_state_management/src/core/di/locator.dart';
import 'package:flutter_state_management/src/core/route/not_found_page.dart';
import 'package:flutter_state_management/src/core/route/routes.dart';
import 'package:flutter_state_management/src/features/auth/sign_in/ui/sign_in_page.dart';
import 'package:flutter_state_management/src/features/auth/sign_up/ui/sign_up_page.dart';
import 'package:flutter_state_management/src/features/category/ui/controllers/category_controller.dart';
import 'package:flutter_state_management/src/features/category/ui/provider/categories_provider.dart';
import 'package:flutter_state_management/src/features/category/ui/views/home_view.dart';
import 'package:flutter_state_management/src/features/important/ui/controllers/important_todo_controller.dart';
import 'package:flutter_state_management/src/features/important/ui/provider/important_todo_controller_provider.dart';
import 'package:flutter_state_management/src/features/important/ui/views/important_todos_view.dart';
import 'package:flutter_state_management/src/features/tasks/ui/tasks_page.dart';
import 'package:flutter_state_management/src/features/todo/ui/views/todos_view.dart';
import 'package:flutter_state_management/src/features/user_profile/ui/user_profile_page.dart';

class RouteManager {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.home:
        return MaterialPageRoute(
          builder: (context) => CategoriesProvider(
            categoryController: CategoryController(
              fetchCategoryUseCase: locator(),
              createCategoryUseCase: locator(),
            ),
            child: const HomeView(),
          ),
          settings: routeSettings,
        );
      case Routes.todos:
        return MaterialPageRoute(
          builder: (_) => const TodosView(),
          settings: routeSettings,
        );
      case Routes.important:
        return MaterialPageRoute(
          builder: (_) => ImportantTodoControllerProvider(
            controller: ImportantTodoController(
              fetchImportantTodosUseCase: locator(),
            ),
            child: const ImportantTodosView(),
          ),
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

  void onCategoryCreateFailed(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }
}
