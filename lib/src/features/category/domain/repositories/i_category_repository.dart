import 'package:flutter_state_management/src/core/base/either.dart';
import 'package:flutter_state_management/src/features/category/data/entities/category_entity.dart';

abstract interface class ICategoryRepository {
  Either<Exception, int> createCategory(CategoryEntity category);

  Either<Exception, List<CategoryEntity>> fetchCategories();

  Either<Exception, Stream<List<CategoryEntity>>> fetchCategoriesStream();
}
