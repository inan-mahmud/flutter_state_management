import 'package:flutter_state_management/src/core/base/either.dart';
import 'package:flutter_state_management/src/core/base/failure.dart';
import 'package:flutter_state_management/src/features/home/data/repositories/home_repository.dart';
import 'package:flutter_state_management/src/features/home/domain/mappers/category_mapper.dart';
import 'package:flutter_state_management/src/features/home/domain/models/category_model.dart';

class FetchCategoryUseCase {
  final HomeRepository _homeRepository;

  FetchCategoryUseCase(this._homeRepository);

  Either<Failure, List<CategoryModel>> fetchCategories() {
    return _homeRepository.fetchCategories().fold(
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
}
