import 'package:flutter/material.dart';
import 'package:flutter_state_management/src/features/todo/domain/models/todo_model.dart';

class TodoModelProvider extends InheritedWidget {
  final TodoModel todoModel;

  const TodoModelProvider(
      {super.key, required super.child, required this.todoModel});

  @override
  bool updateShouldNotify(covariant TodoModelProvider oldWidget) {
    return todoModel != oldWidget.todoModel;
  }

  static TodoModelProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TodoModelProvider>()!;
  }

}
