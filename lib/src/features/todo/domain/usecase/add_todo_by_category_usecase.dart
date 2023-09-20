import 'package:flutter_state_management/src/core/base/either.dart';
import 'package:flutter_state_management/src/core/base/failure.dart';
import 'package:flutter_state_management/src/features/category/domain/mappers/category_mapper.dart';
import 'package:flutter_state_management/src/features/category/domain/models/category_model.dart';
import 'package:flutter_state_management/src/features/todo/data/entities/todo_entity.dart';
import 'package:flutter_state_management/src/features/todo/domain/repositories/i_todo_repository.dart';

class AddTodoByCategoryUseCase {
  final ITodoRepository todoRepository;

  AddTodoByCategoryUseCase({required this.todoRepository});

  Either<Failure, int> addTodoByCategory(
      CategoryModel categoryModel, String title, String description) {
    final todo = TodoEntity(title: title, description: description);
    todo.category.target = categoryModel.toEntity();
    final result = todoRepository.addTodo(todo);
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
