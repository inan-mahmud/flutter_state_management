import 'package:flutter_state_management/main.dart';
import 'package:flutter_state_management/src/core/base/result.dart';
import 'package:flutter_state_management/src/features/home/data/entities/category_entity.dart';

class CategoryRepository {
  Future<Result<int, Exception>> createCategory(CategoryEntity category) async {
    try {
      final id = await databaseService.addCategory(category);
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
