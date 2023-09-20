import 'package:flutter_state_management/src/features/category/data/entities/category_entity.dart';
import 'package:flutter_state_management/src/features/todo/data/entities/todo_entity.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class UserEntity {
  @Id()
  int id;

  String userName;

  String email;



  UserEntity({this.id = 0, required this.userName, required this.email});
}
