import 'dart:async';

import 'package:flutter_state_management/src/features/home/domain/models/category_model.dart';
import 'package:flutter_state_management/src/features/home/domain/usecase/fetch_category_usecase.dart';

class FetchCategoriesController {
  final _todoStreamController = StreamController<List<CategoryModel>>();

  Stream<List<CategoryModel>> get categoryStream =>
      _todoStreamController.stream;

  final FetchCategoryUseCase fetchCategoryUseCase;

  FetchCategoriesController({
    required this.fetchCategoryUseCase,
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

  void dispose() {
    _todoStreamController.close();
  }
}
