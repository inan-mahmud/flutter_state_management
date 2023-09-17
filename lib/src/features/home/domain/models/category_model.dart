import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class CategoryModel extends Equatable {
  final int? id;
  final String title;

  const CategoryModel({this.id, required this.title});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      title: json['title'],
    );
  }

  @override
  List<Object?> get props => [id, title];
}

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
