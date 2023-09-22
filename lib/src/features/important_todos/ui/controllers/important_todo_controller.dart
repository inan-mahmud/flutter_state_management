import 'package:flutter/material.dart';
import 'package:flutter_state_management/src/core/base/result.dart';
import 'package:flutter_state_management/src/features/category/domain/models/category_model.dart';
import 'package:flutter_state_management/src/features/important_todos/domain/usecases/fetch_important_todos_usecase.dart';
import 'package:flutter_state_management/src/features/todo/domain/models/todo_model.dart';

class ImportantTodoController extends ChangeNotifier {
  final FetchImportantTodosUseCase fetchImportantTodosUseCase;

  ImportantTodoController({required this.fetchImportantTodosUseCase});

  Stream<Result<List<TodoModel>>> fetchImportantTodos() async* {
    yield* fetchImportantTodosUseCase.fetchImportantTodos().fold(
      (failure) async* {
        yield Error(failure.message);
      },
      (stream) async* {
        yield* stream.map(
          (List<TodoModel> todos) => Success(todos),
        );
      },
    );
  }
}
