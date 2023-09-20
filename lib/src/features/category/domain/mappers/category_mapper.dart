import 'package:flutter_state_management/src/features/category/data/entities/category_entity.dart';
import 'package:flutter_state_management/src/features/category/domain/models/category_model.dart';
import 'package:flutter_state_management/src/features/todo/domain/mapper/todo_mapper.dart';

extension ToCategoryModel on CategoryEntity {
  CategoryModel toModel() {
    return CategoryModel(
      id: id,
      title: title,
    );
  }
}

extension ToCategoryEntity on CategoryModel {
  CategoryEntity toEntity() {
    return CategoryEntity(
      id: id ?? 0,
      title: title,
    );
  }
}
