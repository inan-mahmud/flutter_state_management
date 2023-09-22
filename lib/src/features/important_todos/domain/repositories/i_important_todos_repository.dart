import 'package:flutter_state_management/src/core/base/either.dart';
import 'package:flutter_state_management/src/features/todo/data/entities/todo_entity.dart';

abstract interface class IImportantTodosRepository {
  Either<Exception, Stream<List<TodoEntity>>> fetchImportantTodos();
}
