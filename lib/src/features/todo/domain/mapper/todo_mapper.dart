import 'package:flutter_state_management/src/features/todo/data/entities/todo_entity.dart';
import 'package:flutter_state_management/src/features/todo/domain/models/todo_model.dart';

extension TodoMapper on TodoEntity {
  TodoModel toModel() {
    return TodoModel(
        id: id,
        title: title,
        description: description,
        categoryId: category.targetId,
        isDone: isDone,
        isImportant: isImportant);
  }
}
