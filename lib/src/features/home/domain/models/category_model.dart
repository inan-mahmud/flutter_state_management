import 'package:flutter_state_management/src/features/todo/domain/models/todo_model.dart';

class CategoryModel {
  final int id;
  final String title;
  final List<TodoModel> todos;
  final int userId;

  CategoryModel(
      {required this.id,
      required this.title,
      required this.todos,
      required this.userId});
}
