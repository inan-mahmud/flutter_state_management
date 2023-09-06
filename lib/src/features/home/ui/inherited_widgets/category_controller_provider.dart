import 'package:flutter/material.dart';
import 'package:flutter_state_management/src/features/home/ui/presenters/cateogries_notifier.dart';

class CategoryControllerProvider extends InheritedWidget {
  final CategoriesPresenter categoriesPresenter;

  const CategoryControllerProvider(
      {super.key, required super.child, required this.categoriesPresenter});

  @override
  bool updateShouldNotify(covariant CategoryControllerProvider oldWidget) {
    return categoriesPresenter != oldWidget.categoriesPresenter;
  }

  static CategoryControllerProvider of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<CategoryControllerProvider>()!;
  }
}
