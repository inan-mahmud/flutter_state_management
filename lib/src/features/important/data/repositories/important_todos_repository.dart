import 'package:flutter_state_management/objectbox.g.dart';
import 'package:flutter_state_management/src/core/base/either.dart';
import 'package:flutter_state_management/src/core/di/locator.dart';
import 'package:flutter_state_management/src/features/important/domain/repositories/i_important_todos_repository.dart';
import 'package:flutter_state_management/src/features/todo/data/entities/todo_entity.dart';

class ImportantTodosRepository implements IImportantTodosRepository {

  final Store store = locator<Store>();

  late final Box<TodoEntity> _todoBox;

  ImportantTodosRepository() {
    _todoBox = Box<TodoEntity>(store);
  }

  @override
  Either<Exception, Stream<List<TodoEntity>>> fetchImportantTodos() {
    try {
      final todos = _todoBox
          .query(TodoEntity_.isImportant.equals(true))
          .order(TodoEntity_.isImportant, flags: Order.descending)
          .watch(triggerImmediately: true)
          .map((todo) => todo.find());
      return right(todos);
    } on Exception catch (exception) {
      return left(exception);
    }
  }

}