import 'package:flutter_state_management/objectbox.g.dart';
import 'package:flutter_state_management/src/core/base/either.dart';
import 'package:flutter_state_management/src/core/di/locator.dart';
import 'package:flutter_state_management/src/features/todo/data/entities/todo_entity.dart';

class TodoRepository {
  final Store store = locator<Store>();

  late final Box<TodoEntity> _todoBox;

  TodoRepository() {
    _todoBox = Box<TodoEntity>(store);
  }

  Either<Exception, int> addTodo(TodoEntity todo) {
    try {
      final id = _todoBox.put(todo);
      return right(id);
    } on Exception catch (exception) {
      return left(exception);
    }
  }

  Either<Exception, List<TodoEntity>> fetchTodos() {
    try {
      final todos = _todoBox.getAll();
      return right(todos);
    } on Exception catch (exception) {
      return left(exception);
    }
  }

  Either<Exception, Stream<List<TodoEntity>>> fetchTodoStreamByCategoryId(
      int id) {
    try {
      final todos = _todoBox
          .query(TodoEntity_.category.equals(id))
          .watch(triggerImmediately: true)
          .map((todo) => todo.find());
      return right(todos);
    } on Exception catch (exception) {
      return left(exception);
    }
  }
}
