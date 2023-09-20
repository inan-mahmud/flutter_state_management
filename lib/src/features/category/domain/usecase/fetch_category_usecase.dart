import 'package:flutter_state_management/src/core/base/either.dart';
import 'package:flutter_state_management/src/core/base/failure.dart';
import 'package:flutter_state_management/src/features/category/domain/mappers/category_mapper.dart';
import 'package:flutter_state_management/src/features/category/domain/models/category_model.dart';
import 'package:flutter_state_management/src/features/category/domain/repositories/i_category_repository.dart';

class FetchCategoryUseCase {
  final ICategoryRepository categoryRepository;

  FetchCategoryUseCase(this.categoryRepository);

  Either<Failure, List<CategoryModel>> fetchCategories() {
    return categoryRepository.fetchCategories().fold(
          (exception) => left(
            Failure(
              message: exception.toString(),
            ),
          ),
          (categories) => right(
            categories.map((category) => category.toModel()).toList(),
          ),
        );
  }

  Either<Failure, Stream<List<CategoryModel>>> fetchCategoriesStream() {
    return categoryRepository.fetchCategoriesStream().fold(
          (exception) => left(
            Failure(
              message: exception.toString(),
            ),
          ),
          (categoriesStream) => right(
            categoriesStream.map(
              (categories) =>
                  categories.map((category) => category.toModel()).toList(),
            ),
          ),
        );
  }
}
