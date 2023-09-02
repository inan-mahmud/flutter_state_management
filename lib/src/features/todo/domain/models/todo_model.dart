class TodoModel {
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
}
