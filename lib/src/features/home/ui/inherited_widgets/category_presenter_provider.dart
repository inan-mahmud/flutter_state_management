import 'package:flutter/material.dart';
import 'package:flutter_state_management/src/features/home/ui/presenters/categories_presenter.dart';

class CategoriesPresenterProvider extends InheritedWidget {
  final CategoriesPresenter categoriesPresenter;

  const CategoriesPresenterProvider(
      {super.key, required super.child, required this.categoriesPresenter});

  @override
  bool updateShouldNotify(covariant CategoriesPresenterProvider oldWidget) {
    return categoriesPresenter != oldWidget.categoriesPresenter;
  }

  static CategoriesPresenterProvider of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<CategoriesPresenterProvider>()!;
  }
}
