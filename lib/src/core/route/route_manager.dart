import 'package:flutter/material.dart';
import 'package:flutter_state_management/src/core/di/locator.dart';
import 'package:flutter_state_management/src/core/route/not_found_page.dart';
import 'package:flutter_state_management/src/core/route/routes.dart';
import 'package:flutter_state_management/src/features/category/ui/controllers/category_controller.dart';
import 'package:flutter_state_management/src/features/category/ui/provider/categories_provider.dart';
import 'package:flutter_state_management/src/features/category/ui/views/home_view.dart';
import 'package:flutter_state_management/src/features/important_todos/ui/controllers/important_todo_controller.dart';
import 'package:flutter_state_management/src/features/important_todos/ui/provider/important_todo_controller_provider.dart';
import 'package:flutter_state_management/src/features/important_todos/ui/views/important_todos_view.dart';
import 'package:flutter_state_management/src/features/tasks/ui/controllers/tasks_controller.dart';
import 'package:flutter_state_management/src/features/tasks/ui/provider/tasks_provider.dart';
import 'package:flutter_state_management/src/features/tasks/ui/views/tasks_view.dart';
import 'package:flutter_state_management/src/features/todo/ui/views/todos_view.dart';

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
          builder: (_) => TasksControllerProvider(
            controller: TasksController(
              fetchTasksUseCase: locator(),
            ),
            child: const TaskView(),
          ),
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
