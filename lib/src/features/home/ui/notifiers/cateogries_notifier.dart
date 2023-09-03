import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_state_management/src/features/home/domain/models/category_model.dart';
import 'package:flutter_state_management/src/features/home/domain/usecase/create_category_usecase.dart';
import 'package:flutter_state_management/src/features/home/domain/usecase/fetch_category_usecase.dart';

class CategoriesViewModel extends ChangeNotifier {
  final FetchCategoryUseCase fetchCategoryUseCase;
  final CreateCategoryUseCase createCategoryUseCase;

  final List<CategoryModel> _categories = [];

  String _errorMessage = '';

  String get errorMessage => _errorMessage;

  UnmodifiableListView<CategoryModel> get categories =>
      UnmodifiableListView(_categories);

  CategoriesViewModel(
      {required this.fetchCategoryUseCase,
      required this.createCategoryUseCase});

  void fetchCategories() {
    fetchCategoryUseCase.fetchCategories().fold(
      (failure) {
        _errorMessage = failure.message;
        notifyListeners();
      },
      (success) {
        print(success);
        _errorMessage = '';
        _categories.addAll(success);
        notifyListeners();
      },
    );
  }

  void createCategory(String category) {
    createCategoryUseCase.createCategory(category).fold(
      (failure) {
        _errorMessage = failure.message;
        notifyListeners();
      },
      (id) => fetchCategories(),
    );
  }
}

class CategoriesController {
  final _todoStreamController = StreamController<List<CategoryModel>>();

  Stream<List<CategoryModel>> get categoryStream =>
      _todoStreamController.stream;

  final FetchCategoryUseCase fetchCategoryUseCase;

  CategoriesController({required this.fetchCategoryUseCase});

  void fetchCategories() {
    fetchCategoryUseCase.fetchCategoriesStream().fold((failure) {
      _todoStreamController.addError(failure.message);
    }, (stream) {
      stream.listen((categories) {
        _todoStreamController.add(categories);
      });
    });
  }

  void addCategory(String categoryName){

  }
}
