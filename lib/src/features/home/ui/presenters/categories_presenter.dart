import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_state_management/src/core/utils/typedefs.dart';
import 'package:flutter_state_management/src/features/home/domain/models/category_model.dart';
import 'package:flutter_state_management/src/features/home/domain/usecase/create_category_usecase.dart';
import 'package:flutter_state_management/src/features/home/domain/usecase/fetch_category_usecase.dart';

class CategoriesPresenter {
  final _todoStreamController = StreamController<List<CategoryModel>>();

  Stream<List<CategoryModel>> get categoryStream =>
      _todoStreamController.stream;

  final FetchCategoryUseCase fetchCategoryUseCase;
  final CreateCategoryUseCase createCategoryUseCase;

  final CategoryCreateFailureCallback createFailed;

  CategoriesPresenter({
    required this.createCategoryUseCase,
    required this.fetchCategoryUseCase,
    required this.createFailed,
  }) {
    _fetchCategories();
  }

  void _fetchCategories() {
    fetchCategoryUseCase.fetchCategoriesStream().fold((failure) {
      _todoStreamController.addError(failure.message);
    }, (stream) {
      stream.listen((categories) {
        _todoStreamController.add(categories);
      });
    });
  }

  void createCategory(String categoryName) {
    createCategoryUseCase.createCategory(categoryName).fold(
      (failure) {
        createFailed(failure.message);
      },
      (id) {
        debugPrint('Category created with id: $id');
      },
    );
  }

  void dispose() {
    _todoStreamController.close();
  }
}
