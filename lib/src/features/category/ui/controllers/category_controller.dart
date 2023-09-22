import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_state_management/src/features/category/domain/models/category_model.dart';
import 'package:flutter_state_management/src/features/category/domain/usecase/create_category_usecase.dart';
import 'package:flutter_state_management/src/features/category/domain/usecase/fetch_category_usecase.dart';
import 'package:flutter_state_management/src/core/base/result.dart';

class CategoryController extends ChangeNotifier {
  ValueNotifier<Result<int>> result = ValueNotifier(Init());
  final _categoryStreamController = StreamController<List<CategoryModel>>();

  Stream<List<CategoryModel>> get categoryStream =>
      _categoryStreamController.stream;

  final FetchCategoryUseCase fetchCategoryUseCase;
  final CreateCategoryUseCase createCategoryUseCase;

  CategoryController({
    required this.fetchCategoryUseCase,
    required this.createCategoryUseCase,
  }) {
    _fetchCategories();
  }

  void _fetchCategories() {
    fetchCategoryUseCase.fetchCategoriesStream().fold((failure) {
      _categoryStreamController.addError(failure.message);
    }, (stream) {
      stream.listen((categories) {
        _categoryStreamController.add(categories);
      });
    });
  }

  void createCategory(String categoryName) {
    createCategoryUseCase.createCategory(categoryName).fold((failure) {
      result.value = Error(failure.message);
    }, (id) {
      result.value = Success(id);
    });
    notifyListeners();
  }

  @override
  void dispose() {
    _categoryStreamController.close();
    super.dispose();
  }
}
