import 'package:flutter_state_management/src/core/base/either.dart';
import 'package:flutter_state_management/src/core/base/failure.dart';
import 'package:flutter_state_management/src/features/todo/data/repositories/todo_repository.dart';
import 'package:flutter_state_management/src/features/todo/domain/mapper/todo_mapper.dart';
import 'package:flutter_state_management/src/features/todo/domain/models/todo_model.dart';

class FetchTodosByCategoryUseCase {
  final TodoRepository todoRepository;

  FetchTodosByCategoryUseCase({required this.todoRepository});

  Either<Failure, Stream<List<TodoModel>>> fetchTodosStreamByCategory(int id) {
    return todoRepository.fetchTodoStreamByCategoryId(id).fold(
          (exception) => left(
            Failure(
              message: exception.toString(),
            ),
          ),
          (todosStream) => right(
            todosStream.map(
              (todos) {
                return todos.map((todo) {
                  print(todo.title);
                  return todo.toModel();
                }).toList();
              },
            ),
          ),
        );
  }
}
