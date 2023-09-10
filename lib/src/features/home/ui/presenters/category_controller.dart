import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_state_management/src/features/home/domain/models/category_model.dart';
import 'package:flutter_state_management/src/features/home/domain/usecase/create_category_usecase.dart';
import 'package:flutter_state_management/src/features/home/domain/usecase/fetch_category_usecase.dart';
import 'package:flutter_state_management/src/features/home/ui/state/home_state.dart';

class CategoryController extends ChangeNotifier {
  Result<int> value = Init();
  final _todoStreamController = StreamController<List<CategoryModel>>();

  Stream<List<CategoryModel>> get categoryStream =>
      _todoStreamController.stream;

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
      _todoStreamController.addError(failure.message);
    }, (stream) {
      stream.listen((categories) {
        _todoStreamController.add(categories);
      });
    });
  }

  void createCategory(String categoryName) {
    createCategoryUseCase.createCategory(categoryName).fold((failure) {
      value = Error(failure.message);
    }, (id) {
      value = Success(id);
    });
    notifyListeners();
  }

  @override
  void dispose() {
    _todoStreamController.close();
    super.dispose();
  }
}
