import 'package:flutter_state_management/objectbox.g.dart';
import 'package:flutter_state_management/src/core/base/either.dart';
import 'package:flutter_state_management/src/core/di/locator.dart';
import 'package:flutter_state_management/src/features/todo/data/entities/todo_entity.dart';

abstract interface class ITodoRepository {
  Either<Exception, int> addTodo(TodoEntity todo);

  Either<Exception, List<TodoEntity>> fetchTodos();

  Either<Exception, Stream<List<TodoEntity>>> fetchTodoStreamByCategoryId(
      int id);

  Either<Exception, int> updateTodo(TodoEntity todoEntity);
}
