import 'package:flutter/material.dart';
import 'package:flutter_state_management/src/core/base/result.dart';
import 'package:flutter_state_management/src/features/tasks/domain/usecases/add_tasks_usecase.dart';
import 'package:flutter_state_management/src/features/tasks/domain/usecases/fetch_tasks_usecase.dart';
import 'package:flutter_state_management/src/features/todo/domain/models/todo_model.dart';

class TasksController extends ChangeNotifier {
  final FetchTasksUseCase fetchTasksUseCase;
  final AddTaskUseCase addTaskUseCase;

  Result<int> todoResult = Init();

  TasksController({
    required this.fetchTasksUseCase,
    required this.addTaskUseCase,
  });

  Stream<Result<List<TodoModel>>> fetchTasks() async* {
    yield* fetchTasksUseCase.fetchTasks().fold(
      (failure) async* {
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

  void addTodo(String title, String description) {
    final result = addTaskUseCase.addTask(title, description);
    result.fold((failure) {
      todoResult = Error(failure.message);
      notifyListeners();
    }, (id) {
      todoResult = Success(id);
      notifyListeners();
    });
  }
}
