import 'package:equatable/equatable.dart';

class TodoModel extends Equatable {
  final int id;
  final String title;
  final String description;
  final bool isDone;
  final bool isImportant;

  TodoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.isDone,
    required this.isImportant,
  });

  @override
  List<Object?> get props => [id, title, description, isDone, isImportant];

  TodoModel copyWith({
    int? id,
    String? title,
    String? description,
    bool? isDone,
    bool? isImportant,
  }) =>
      TodoModel(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        isDone: isDone ?? this.isDone,
        isImportant: isImportant ?? this.isImportant,
      );

  @override
  bool? get stringify => true;
}
