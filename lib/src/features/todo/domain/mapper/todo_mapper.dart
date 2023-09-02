import 'package:flutter_state_management/src/features/todo/data/entities/todo_entity.dart';
import 'package:flutter_state_management/src/features/todo/domain/models/todo_model.dart';

extension ToTodoModel on TodoEntity {
  TodoModel toModel() {
    return TodoModel(
        id: id,
        title: title,
        description: description,
        isDone: isDone,
        isImportant: isImportant);
  }
}

extension ToTodoEntity on TodoModel {
  TodoEntity toEntity() {
    return TodoEntity(
        id: id,
        title: title,
        description: description,
        isDone: isDone,
        isImportant: isImportant);
  }
}
