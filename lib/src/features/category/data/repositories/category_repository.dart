import 'package:flutter_state_management/objectbox.g.dart';
import 'package:flutter_state_management/src/core/base/either.dart';
import 'package:flutter_state_management/src/core/di/locator.dart';
import 'package:flutter_state_management/src/features/category/data/entities/category_entity.dart';
import 'package:flutter_state_management/src/features/category/domain/repositories/i_category_repository.dart';

class CategoryRepository implements ICategoryRepository {
  final Store store = locator<Store>();

  late final Box<CategoryEntity> _categoryBox;

  CategoryRepository() {
    _categoryBox = Box<CategoryEntity>(store);
  }

  @override
  Either<Exception, int> createCategory(CategoryEntity category) {
    try {
      final id = _categoryBox.put(category);
      return right(id);
    } on Exception catch (exception) {
      return left(exception);
    }
  }

  @override
  Either<Exception, List<CategoryEntity>> fetchCategories() {
    try {
      final categories = _categoryBox.getAll();
      return right(categories);
    } on Exception catch (exception) {
      return left(exception);
    }
  }

  @override
  Either<Exception, Stream<List<CategoryEntity>>> fetchCategoriesStream() {
    try {
      final categories = _categoryBox
          .query()
          .watch(triggerImmediately: true)
          .map((event) => event.find());
      return right(categories);
    } on Exception catch (exception) {
      return left(exception);
    }
  }
}
