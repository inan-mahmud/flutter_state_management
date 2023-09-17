import 'package:flutter/material.dart';
import 'package:flutter_state_management/src/features/home/domain/models/category_model.dart';

class CategoryModelProvider extends InheritedWidget {
  final CategoryModel categoryModel;

  const CategoryModelProvider(
      {super.key, required super.child, required this.categoryModel});

  @override
  bool updateShouldNotify(covariant CategoryModelProvider oldWidget) {
    return categoryModel != oldWidget.categoryModel;
  }

  static CategoryModelProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CategoryModelProvider>()!;
  }
}
