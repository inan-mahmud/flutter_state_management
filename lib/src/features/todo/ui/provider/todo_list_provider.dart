import 'package:flutter/material.dart';
import 'package:flutter_state_management/src/features/todo/domain/models/todo_model.dart';

class TodoListProvider extends InheritedWidget {
  final List<TodoModel> todoList;

  TodoListProvider({super.key, required super.child, required this.todoList});

  @override
  bool updateShouldNotify(covariant TodoListProvider oldWidget) {
    return oldWidget.todoList != todoList;
  }

  static TodoListProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TodoListProvider>()!;
  }
}
