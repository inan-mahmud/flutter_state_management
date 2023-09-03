import 'package:flutter/material.dart';
import 'package:flutter_state_management/src/features/home/ui/notifiers/cateogries_notifier.dart';

class CategoryControllerModel extends InheritedWidget {
  final CategoriesController categoriesNotifier;

  const CategoryControllerModel(
      {super.key, required super.child, required this.categoriesNotifier});

  @override
  bool updateShouldNotify(covariant CategoryControllerModel oldWidget) {
    return categoriesNotifier != oldWidget.categoriesNotifier;
  }

  static CategoryControllerModel of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CategoryControllerModel>()!;
  }
}
