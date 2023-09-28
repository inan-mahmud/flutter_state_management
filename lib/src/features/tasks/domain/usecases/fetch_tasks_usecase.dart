import 'package:flutter_state_management/src/core/base/either.dart';
import 'package:flutter_state_management/src/core/base/failure.dart';
import 'package:flutter_state_management/src/features/tasks/domain/repositories/i_tasks_repository.dart';
import 'package:flutter_state_management/src/features/todo/domain/mapper/todo_mapper.dart';
import 'package:flutter_state_management/src/features/todo/domain/models/todo_model.dart';

class FetchTasksUseCase {
  final ITasksRepository tasksRepository;

  FetchTasksUseCase({required this.tasksRepository});

  Either<Failure, Stream<List<TodoModel>>> fetchTasks() {
    return tasksRepository.fetchTasks().fold((exception) {
      return Left(Failure(message: "Couldn't fetch tasks"));
    }, (todosStream) {
      return right(
        todosStream.map(
          (todos) => todos
              .map(
                (todo) => todo.toModel(),
              )
              .toList(),
        ),
      );
    });
  }
}
