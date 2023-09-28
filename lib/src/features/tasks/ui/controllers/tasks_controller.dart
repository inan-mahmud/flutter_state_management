import 'package:flutter/material.dart';
import 'package:flutter_state_management/src/core/base/result.dart';
import 'package:flutter_state_management/src/features/tasks/domain/usecases/fetch_tasks_usecase.dart';
import 'package:flutter_state_management/src/features/todo/domain/models/todo_model.dart';

class TasksController extends ChangeNotifier {
  final FetchTasksUseCase fetchTasksUseCase;

  TasksController({required this.fetchTasksUseCase});

  Stream<Result<List<TodoModel>>> fetchTasks() async* {
    yield* fetchTasksUseCase.fetchTasks().fold(
      (failure) async* {
        print(failure.message);
        yield Error(failure.message);
      },
      (stream) async* {
        yield* stream.map(
          (List<TodoModel> todos) {
            return Success(todos);
          },
        );
      },
    );
  }
}
