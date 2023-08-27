import 'package:flutter_state_management/src/features/todo/data/entities/todo_entity.dart';
import 'package:flutter_state_management/src/features/user_profile/data/entity/user_entity.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class CategoryEntity {
  @Id()
  int id;

  String title;

  @Backlink()
  final todos = ToMany<TodoEntity>();

  final user = ToOne<UserEntity>();

  CategoryEntity({this.id = 0, required this.title});
}
