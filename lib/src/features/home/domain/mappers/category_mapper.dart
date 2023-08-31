import 'package:flutter_state_management/src/features/home/data/entities/category_entity.dart';
import 'package:flutter_state_management/src/features/home/domain/models/category_model.dart';

extension CategoryMapper on CategoryEntity {
  CategoryModel toModel() {
    return CategoryModel(
      id: id,
      title: title,
      userId: user.targetId,
      todos: todos.map((todo) => todo.toModel()).toList(),
    );
  }
}
