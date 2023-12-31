import 'package:flutter/material.dart';
import 'package:flutter_state_management/src/core/base/either.dart';
import 'package:flutter_state_management/src/core/base/failure.dart';
import 'package:flutter_state_management/src/features/category/data/entities/category_entity.dart';
import 'package:flutter_state_management/src/features/category/domain/repositories/i_category_repository.dart';

class CreateCategoryUseCase {
  final ICategoryRepository categoryRepository;

  const CreateCategoryUseCase(this.categoryRepository);

  Either<Failure, int> createCategory(String category) {
    return categoryRepository
        .createCategory(
      CategoryEntity(title: category),
    )
        .fold(
      (exception) {
        debugPrint("Add Category $exception");
        return left(
          Failure(message: 'Something went wrong, Please try again'),
        );
      },
      (id) => right(id),
    );
  }
}
