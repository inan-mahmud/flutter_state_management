import 'package:flutter/material.dart';
import 'package:flutter_state_management/src/features/todo/ui/controllers/todos_controller.dart';

class TodoProvider extends InheritedWidget {
  final TodosController todoController;

  const TodoProvider(
      {super.key, required super.child, required this.todoController});

  @override
  bool updateShouldNotify(covariant TodoProvider oldWidget) {
    return todoController != oldWidget.todoController;
  }

  static TodoProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TodoProvider>()!;
  }
}
