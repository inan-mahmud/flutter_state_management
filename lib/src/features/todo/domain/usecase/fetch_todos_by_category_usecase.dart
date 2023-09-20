import 'package:flutter_state_management/src/core/base/either.dart';
import 'package:flutter_state_management/src/core/base/failure.dart';
import 'package:flutter_state_management/src/features/todo/domain/mapper/todo_mapper.dart';
import 'package:flutter_state_management/src/features/todo/domain/models/todo_model.dart';
import 'package:flutter_state_management/src/features/todo/domain/repositories/i_todo_repository.dart';

class FetchTodosByCategoryUseCase {
  final ITodoRepository todoRepository;

  FetchTodosByCategoryUseCase({required this.todoRepository});

  Either<Failure, Stream<List<TodoModel>>> fetchTodosStreamByCategory(int id) {
    return todoRepository.fetchTodoStreamByCategoryId(id).fold(
      (exception) => left(
        Failure(
          message: exception.toString(),
        ),
      ),
      (todosStream) {
        return right(
          todosStream.map(
            (todos) {
              return todos.map((todo) {
                return todo.toModel();
              }).toList();
            },
          ),
        );
      },
    );
  }
}
