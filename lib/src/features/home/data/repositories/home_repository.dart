import 'package:flutter_state_management/main.dart';
import 'package:flutter_state_management/src/core/base/either.dart';
import 'package:flutter_state_management/src/features/home/data/entities/category_entity.dart';
import 'package:flutter_state_management/src/features/todo/data/entities/todo_entity.dart';

class HomeRepository {
  Either<Exception, int> createCategory(CategoryEntity category) {
    try {
      final id = databaseService.addCategory(category);
      return right(id);
    } on Exception catch (exception) {
      return left(exception);
    }
  }

  Either<Exception, List<CategoryEntity>> fetchCategories() {
    try {
      final categories = databaseService.fetchCategories();
      return right(categories);
    } on Exception catch (exception) {
      return left(exception);
    }
  }

  Either<Exception, List<TodoEntity>> fetchTodosByCategory(int categoryId) {
    try {
      final todos = databaseService.fetchTodosByCategory(categoryId);
      return right(todos);
    } on Exception catch (exception) {
      return left(exception);
    }
  }

  Either<Exception, int> addTodo(TodoEntity todoEntity) {
    try {
      final id = databaseService.addTodoEntity(todoEntity);
      return right(id);
    } on Exception catch (exception) {
      return left(exception);
    }
  }

  Either<Exception, int> updateTodoEntity(TodoEntity todoEntity) {
    try {
      final id = databaseService.addTodoEntity(todoEntity);
      return right(id);
    } on Exception catch (exception) {
      return left(exception);
    }
  }

// Future<Result<List<CategoryEntity>, Exception>> getAllCategories() async {
//   try {
//     final categories = await databaseService.getAllCategories();
//     return Success(categories);
//   } on Exception catch (exception) {
//     return Failure(exception);
//   }
// }
}
