import 'package:flutter_state_management/src/core/base/either.dart';
import 'package:flutter_state_management/src/core/base/failure.dart';
import 'package:flutter_state_management/src/features/category/domain/mappers/category_mapper.dart';
import 'package:flutter_state_management/src/features/category/domain/models/category_model.dart';
import 'package:flutter_state_management/src/features/todo/domain/mapper/todo_mapper.dart';
import 'package:flutter_state_management/src/features/todo/domain/models/todo_model.dart';
import 'package:flutter_state_management/src/features/todo/domain/repositories/i_todo_repository.dart';

class UpdateTodoUseCase {
  final ITodoRepository todoRepository;

  UpdateTodoUseCase({required this.todoRepository});

  Either<Failure, int> updateTodo(TodoModel todoModel) {
    final todoEntity = todoModel.toEntity();
    final result = todoRepository.updateTodo(todoEntity);
    return result.fold(
      (exception) => Left(
        Failure(message: "Couldn't update the todo"),
      ),
      (id) => Right(id),
    );
  }
}
