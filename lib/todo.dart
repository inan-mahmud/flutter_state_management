import 'package:uuid/uuid.dart';

class Todo {
  String id;
  String title;
  String description;
  bool isDone;

  Todo({
    required this.title,
    required this.description,
    this.isDone = false,
  }) : id = Uuid().v4(); // Create UUID in the constructor

  @override
  operator ==(Object other) =>
      identical(this, other) ||
      other is Todo &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          description == other.description &&
          isDone == other.isDone;

  @override
  int get hashCode {
    int result = 17;
    result = 31 * result + title.hashCode;
    result = 31 * result + description.hashCode;
    result = 31 * result + isDone.hashCode;
    return result;
  }
}
