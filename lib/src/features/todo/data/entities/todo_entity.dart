import 'package:flutter_state_management/src/features/home/data/entities/category_entity.dart';
import 'package:flutter_state_management/src/features/user_profile/data/entity/user_entity.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class TodoEntity {
  @Id()
  int id;

  String title;

  String description;

  bool isDone;

  bool isImportant;

  final category = ToOne<CategoryEntity>();

  final user = ToOne<UserEntity>();

  TodoEntity(
      {this.id = 0,
      required this.title,
      this.description = '',
      this.isDone = false,
      this.isImportant = false});
}
