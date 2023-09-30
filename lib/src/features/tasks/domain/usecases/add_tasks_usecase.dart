import 'package:flutter_state_management/src/core/base/either.dart';
import 'package:flutter_state_management/src/core/base/failure.dart';
import 'package:flutter_state_management/src/features/tasks/domain/repositories/i_tasks_repository.dart';
import 'package:flutter_state_management/src/features/todo/data/entities/todo_entity.dart';

class AddTaskUseCase {
  final ITasksRepository tasksRepository;

  AddTaskUseCase({required this.tasksRepository});

  Either<Failure, int> addTask(String title, String description) {
    final todo = TodoEntity(title: title, description: description);
    final result = tasksRepository.addTask(todo);
    return result.fold(
      (exception) {
        return left(Failure(message: "Unknown Error"));
      },
      (id) {
        return right(id);
      },
    );
  }
}
