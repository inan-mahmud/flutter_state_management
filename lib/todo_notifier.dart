import 'package:flutter/foundation.dart';
import 'package:flutter_state_management/todo.dart';

class TodoNotifier extends ValueNotifier<List<Todo>> {
  TodoNotifier() : super([]);

  void add(Todo todo) {
    value.add(todo);
    notifyListeners();
  }

  void remove(Todo todo) {
    value.remove(todo);
    notifyListeners();
  }

  void clear() {
    value.clear();
    notifyListeners();
  }

  void update(int index, Todo todo) {
    value[index] = todo;
    notifyListeners();
  }
}
