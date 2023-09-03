import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_state_management/src/features/home/domain/models/category_model.dart';
import 'package:flutter_state_management/src/features/home/domain/usecase/create_category_usecase.dart';
import 'package:flutter_state_management/src/features/home/domain/usecase/fetch_category_usecase.dart';
import 'package:flutter_state_management/src/features/home/ui/state/home_state.dart';

class CategoriesNotifier extends ValueNotifier<HomeState> {
  final FetchCategoryUseCase fetchCategoryUseCase;

  CategoriesNotifier(this.fetchCategoryUseCase) : super(HomeStateInitial());

  Future<void> fetchCategories() async {
    value = HomeStateLoading();
    await Future.delayed(
      const Duration(seconds: 1),
    );
    final result = fetchCategoryUseCase.fetchCategories();
    result.fold(
      (failure) {
        value = HomeStateFailure(failure.message);
      },
      (categories) {
        value = HomeStateSuccess(categories);
      },
    );
  }
}

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
        _errorMessage = '';
        _categories.clear();
        _categories.addAll(success);
        notifyListeners();
      },
    );
  }

  void createCategory(CategoryModel category) {
    createCategoryUseCase.createCategory(category).fold(
      (failure) {
        _errorMessage = failure.message;
        notifyListeners();
      },
      (id) => fetchCategories(),
    );
  }
}
