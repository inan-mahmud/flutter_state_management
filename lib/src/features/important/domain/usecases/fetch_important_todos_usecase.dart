import 'package:flutter_state_management/src/core/base/either.dart';
import 'package:flutter_state_management/src/core/base/failure.dart';
import 'package:flutter_state_management/src/features/important/domain/repositories/i_important_todos_repository.dart';
import 'package:flutter_state_management/src/features/todo/domain/mapper/todo_mapper.dart';
import 'package:flutter_state_management/src/features/todo/domain/models/todo_model.dart';

class FetchImportantTodosUseCase {
  final IImportantTodosRepository importantTodosRepository;

  FetchImportantTodosUseCase({required this.importantTodosRepository});

  Either<Failure, Stream<List<TodoModel>>> fetchImportantTodos() {
    return importantTodosRepository.fetchImportantTodos().fold((exception) {
      return Left(Failure(message: "Couldn't fetch important todos"));
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
