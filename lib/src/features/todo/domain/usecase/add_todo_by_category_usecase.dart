import 'package:flutter/material.dart';
import 'package:flutter_state_management/src/core/base/either.dart';
import 'package:flutter_state_management/src/core/base/failure.dart';
import 'package:flutter_state_management/src/features/todo/data/entities/todo_entity.dart';
import 'package:flutter_state_management/src/features/todo/data/repositories/todo_repository.dart';

class AddTodoByCategoryUseCase {
  final TodoRepository todoRepository;

  AddTodoByCategoryUseCase({required this.todoRepository});

  Either<Failure, int> addTodoByCategory(
      int categoryId, String title, String description) {
    final todo = TodoEntity(title: title, description: description);
    todo.category.target?.id = categoryId;
    final result = todoRepository.addTodo(todo);
    return result.fold((exception) {
      debugPrint("Add Todo $exception");
      return left(Failure(message: "Unknown Error"));
    }, (id) => right(id));
  }
}
