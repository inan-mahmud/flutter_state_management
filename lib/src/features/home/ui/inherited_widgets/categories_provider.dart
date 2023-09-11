import 'package:flutter/material.dart';
import 'package:flutter_state_management/src/features/home/ui/presenters/category_controller.dart';

class CategoriesProvider extends InheritedWidget {
  final CategoryController categoryController;

  const CategoriesProvider({
    super.key,
    required super.child,
    required this.categoryController,
  });

  @override
  bool updateShouldNotify(covariant CategoriesProvider oldWidget) {
    return categoryController != oldWidget.categoryController;
  }

  static CategoriesProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CategoriesProvider>()!;
  }
}
