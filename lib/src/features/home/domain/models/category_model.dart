class CategoryModel {
  final int? id;
  final String title;

  CategoryModel({this.id, required this.title});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      title: json['title'],
    );
  }
}
