import 'package:flutter/material.dart';
import 'package:flutter_state_management/src/features/home/ui/presenters/cateogries_notifier.dart';


class CategoryInheritedWidget extends InheritedWidget {
  final CategoriesViewModel categoriesNotifier;

  const CategoryInheritedWidget(
      {super.key, required super.child, required this.categoriesNotifier});

  @override
  bool updateShouldNotify(covariant CategoryInheritedWidget oldWidget) {
    return categoriesNotifier != oldWidget.categoriesNotifier;
  }

  static CategoryInheritedWidget of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<CategoryInheritedWidget>()!;
  }
}
