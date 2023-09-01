import 'package:flutter/material.dart';
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
