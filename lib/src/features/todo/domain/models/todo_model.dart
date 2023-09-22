import 'package:equatable/equatable.dart';
import 'package:flutter_state_management/src/features/category/domain/models/category_model.dart';

class TodoModel extends Equatable {
  final int id;
  final String title;
  final String description;
  final bool isDone;
  final bool isImportant;
  final CategoryModel? categoryModel;

  const TodoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.isDone,
    required this.isImportant,
    this.categoryModel,
  });

  @override
  List<Object?> get props =>
      [id, title, description, isDone, isImportant, categoryModel];

  TodoModel copyWith({
    int? id,
    String? title,
    String? description,
    bool? isDone,
    bool? isImportant,
    CategoryModel? model,
  }) =>
      TodoModel(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        isDone: isDone ?? this.isDone,
        isImportant: isImportant ?? this.isImportant,
        categoryModel: model ?? categoryModel,
      );

  @override
  bool? get stringify => true;
}
