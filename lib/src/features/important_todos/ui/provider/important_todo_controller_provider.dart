import 'package:flutter/material.dart';
import 'package:flutter_state_management/src/features/important_todos/ui/controllers/important_todo_controller.dart';

class ImportantTodoControllerProvider extends InheritedWidget {
  final ImportantTodoController controller;

  const ImportantTodoControllerProvider(
      {super.key, required super.child, required this.controller});

  @override
  bool updateShouldNotify(covariant ImportantTodoControllerProvider oldWidget) {
    return controller != oldWidget.controller;
  }

  static ImportantTodoControllerProvider of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<ImportantTodoControllerProvider>()!;
  }
}
