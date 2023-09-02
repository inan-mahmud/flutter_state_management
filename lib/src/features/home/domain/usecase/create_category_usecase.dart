import 'package:flutter/material.dart';
import 'package:flutter_state_management/src/core/base/either.dart';
import 'package:flutter_state_management/src/core/base/failure.dart';
import 'package:flutter_state_management/src/features/home/data/repositories/category_repository.dart';
import 'package:flutter_state_management/src/features/home/data/repositories/home_repository.dart';
import 'package:flutter_state_management/src/features/home/domain/mappers/category_mapper.dart';
import 'package:flutter_state_management/src/features/home/domain/models/category_model.dart';

class CreateCategoryUseCase {
  final CategoryRepository categoryRepository;

  const CreateCategoryUseCase(this.categoryRepository);

  Either<Failure, int> createCategory(CategoryModel category) {
    return categoryRepository.createCategory(category.toEntity()).fold(
      (exception) {
        debugPrint("Add Category Exception $exception");
        return left(
          Failure(message: 'Something went wrong, Please try again'),
        );
      },
      (id) => right(id),
    );
  }
}
