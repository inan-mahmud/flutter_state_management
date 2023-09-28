import 'package:flutter_state_management/src/features/category/data/entities/category_entity.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class TodoEntity {
  @Id()
  int id;

  String title;

  String description;

  bool isDone;

  bool isImportant;

  DateTime createdAt;

  DateTime updatedAt;

  final category = ToOne<CategoryEntity>();


  TodoEntity(
      {this.id = 0,
      required this.title,
      this.description = '',
      this.isDone = false,
      this.isImportant = false,
      DateTime? createdAt,
      DateTime? updatedAt})
      : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  @override
  String toString() {
    return 'TodoEntity(id: $id, title: $title, description: $description, isDone: $isDone, isImportant: $isImportant, createdAt: $createdAt, updatedAt: $updatedAt, category: ${category.target?.title},)';
  }
}
