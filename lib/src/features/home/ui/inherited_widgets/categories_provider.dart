import 'package:flutter/material.dart';
import 'package:flutter_state_management/src/features/home/ui/presenters/fetch_categories_controller.dart';
import 'package:flutter_state_management/src/features/home/ui/presenters/create_category_notifier.dart';

class CategoriesProvider extends InheritedWidget {
  final FetchCategoriesController categoriesPresenter;
  final CreateCategoryNotifier createCategoryNotifier;

  const CategoriesProvider({
    super.key,
    required super.child,
    required this.categoriesPresenter,
    required this.createCategoryNotifier,
  });

  @override
  bool updateShouldNotify(covariant CategoriesProvider oldWidget) {
    return categoriesPresenter != oldWidget.categoriesPresenter;
  }

  static CategoriesProvider of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<CategoriesProvider>()!;
  }
}
