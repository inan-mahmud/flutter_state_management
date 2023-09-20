import 'package:flutter_state_management/objectbox.g.dart';
import 'package:flutter_state_management/src/core/base/either.dart';
import 'package:flutter_state_management/src/core/di/locator.dart';
import 'package:flutter_state_management/src/features/todo/data/entities/todo_entity.dart';
import 'package:flutter_state_management/src/features/todo/domain/repositories/i_todo_repository.dart';

class TodoRepository implements ITodoRepository {
  final Store store = locator<Store>();

  late final Box<TodoEntity> _todoBox;

  TodoRepository() {
    _todoBox = Box<TodoEntity>(store);
  }

  @override
  Either<Exception, int> addTodo(TodoEntity todo) {
    try {
      final id = _todoBox.put(todo);
      return right(id);
    } on Exception catch (exception) {
      return left(exception);
    }
  }

  @override
  Either<Exception, List<TodoEntity>> fetchTodos() {
    try {
      final todos = _todoBox.getAll();
      print(todos);
      return right(todos);
    } on Exception catch (exception) {
      return left(exception);
    }
  }

  @override
  Either<Exception, Stream<List<TodoEntity>>> fetchTodoStreamByCategoryId(
      int id) {
    try {
      final todos = _todoBox
          .query(TodoEntity_.category.equals(id))
          .order(TodoEntity_.isImportant, flags: Order.descending)
          .watch(triggerImmediately: true)
          .map((todo) => todo.find());
      return right(todos);
    } on Exception catch (exception) {
      return left(exception);
    }
  }

  @override
  Either<Exception, int> updateTodo(TodoEntity todoEntity) {
    try {
      final id = _todoBox.put(todoEntity, mode: PutMode.update);
      return right(id);
    } on Exception catch (exception) {
      return left(exception);
    }
  }
}
