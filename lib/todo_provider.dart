import 'package:flutter/widgets.dart';
import 'package:flutter_state_management/todo_notifier.dart';

class TodoProvider extends InheritedWidget {
  final TodoNotifier todoNotifier;

  const TodoProvider(
      {super.key, required Widget child, required this.todoNotifier})
      : super(child: child);

  @override
  bool updateShouldNotify(covariant TodoProvider oldWidget) {
    return oldWidget.todoNotifier != todoNotifier;
  }

  static TodoProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TodoProvider>()!;
  }
}
