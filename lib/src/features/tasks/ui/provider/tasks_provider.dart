import 'package:flutter/material.dart';
import 'package:flutter_state_management/src/features/tasks/ui/controllers/tasks_controller.dart';

class TasksControllerProvider extends InheritedWidget {
  final TasksController controller;

  const TasksControllerProvider(
      {super.key, required super.child, required this.controller});

  @override
  bool updateShouldNotify(covariant TasksControllerProvider oldWidget) {
    return controller != oldWidget.controller;
  }

  static TasksControllerProvider of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<TasksControllerProvider>()!;
  }
}
