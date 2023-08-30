import 'package:flutter_state_management/src/features/home/data/entities/category_entity.dart';
import 'package:flutter_state_management/src/features/todo/data/entities/todo_entity.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class UserEntity {
  @Id()
  int id;

  String userName;

  String email;

  @Backlink()
  final categories = ToMany<CategoryEntity>();

  @Backlink()
  final todos = ToMany<TodoEntity>();

  UserEntity({this.id = 0, required this.userName, required this.email});
}
