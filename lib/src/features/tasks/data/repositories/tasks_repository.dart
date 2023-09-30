import 'package:flutter_state_management/objectbox.g.dart';
import 'package:flutter_state_management/src/core/base/either.dart';
import 'package:flutter_state_management/src/core/di/locator.dart';
import 'package:flutter_state_management/src/features/tasks/domain/repositories/i_tasks_repository.dart';
import 'package:flutter_state_management/src/features/todo/data/entities/todo_entity.dart';

class TaskRepository implements ITasksRepository {
  final Store store = locator<Store>();

  late final Box<TodoEntity> _taskBox;

  TaskRepository() {
    _taskBox = Box<TodoEntity>(store);
  }

  @override
  Either<Exception, Stream<List<TodoEntity>>> fetchTasks() {
    try {
      final todos = _taskBox
          .query(TodoEntity_.category.equals(0))
          .order(TodoEntity_.isImportant, flags: Order.descending)
          .watch(triggerImmediately: true)
          .map((todo) => todo.find());
      return right(todos);
    } on Exception catch (exception) {
      return left(exception);
    }
  }

  @override
  Either<Exception, int> addTask(TodoEntity todoEntity) {
    try {
      final id = _taskBox.put(todoEntity);
      return right(id);
    } on Exception catch (exception) {
      return left(exception);
    }
  }
}
