import 'package:flutter/material.dart';
import 'package:flutter_state_management/src/features/home/ui/presenters/cateogries_notifier.dart';

class CategoryControllerProvider extends InheritedWidget {
  final CategoriesController categoriesNotifier;

  const CategoryControllerProvider(
      {super.key, required super.child, required this.categoriesNotifier});

  @override
  bool updateShouldNotify(covariant CategoryControllerProvider oldWidget) {
    return categoriesNotifier != oldWidget.categoriesNotifier;
  }

  static CategoryControllerProvider of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<CategoryControllerProvider>()!;
  }
}
