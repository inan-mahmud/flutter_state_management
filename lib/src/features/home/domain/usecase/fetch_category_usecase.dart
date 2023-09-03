import 'package:flutter_state_management/src/core/base/either.dart';
import 'package:flutter_state_management/src/core/base/failure.dart';
import 'package:flutter_state_management/src/features/home/data/repositories/category_repository.dart';
import 'package:flutter_state_management/src/features/home/domain/mappers/category_mapper.dart';
import 'package:flutter_state_management/src/features/home/domain/models/category_model.dart';

class FetchCategoryUseCase {
  final CategoryRepository categoryRepository;

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
