class TodoModel {
  final int id;
  final String title;
  final String description;
  final bool isDone;
  final bool isImportant;
  final int categoryId;

  TodoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.isDone,
    required this.isImportant,
  });
}
