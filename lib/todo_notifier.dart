import 'package:flutter/foundation.dart';
import 'package:flutter_state_management/src/features/todo/data/entities/todo_entity.dart';

class TodoNotifier extends ValueNotifier<List<TodoEntity>> {
  TodoNotifier() : super([]);

  void add(TodoEntity todo) {
    value.add(todo);
    notifyListeners();
  }

  void remove(TodoEntity todo) {
    value.remove(todo);
    notifyListeners();
  }

  void clear() {
    value.clear();
    notifyListeners();
  }

  void update(int index, TodoEntity todo) {
    value[index] = todo;
    notifyListeners();
  }
}
