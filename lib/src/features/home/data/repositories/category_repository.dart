import 'package:flutter_state_management/main.dart';
import 'package:flutter_state_management/src/core/base/result.dart';
import 'package:flutter_state_management/src/features/home/data/entities/category_entity.dart';
import 'package:flutter_state_management/src/features/todo/data/entities/todo_entity.dart';

class CategoryRepository {
  Result<int, Exception> createCategory(CategoryEntity category) {
    try {
      final id = databaseService.addCategory(category);
      return Success(id);
    } on Exception catch (exception) {
      return Failure(exception);
    }
  }

  Result<List<CategoryEntity>, Exception> fetchCategories() {
    try {
      final categories = databaseService.fetchCategories();
      return Success(categories);
    } on Exception catch (exception) {
      return Failure(exception);
    }
  }

  Result<List<TodoEntity>, Exception> fetchTodosByCategory(int categoryId) {
    try {
      final todos = databaseService.fetchTodosByCategory(categoryId);
      return Success(todos);
    } on Exception catch (exception) {
      return Failure(exception);
    }
  }

  Result<int,Exception> addTodo(TodoEntity todoEntity){
    try {
      final id = databaseService.addTodoEntity(todoEntity);
      return Success(id);
    } on Exception catch (exception) {
      return Failure(exception);
    }
  }

  Result<int,Exception> updateTodoEntity(TodoEntity todoEntity) {
    try {
      final id = databaseService.addTodoEntity(todoEntity);
      return Success(id);
    } on Exception catch (exception) {
      return Failure(exception);
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
