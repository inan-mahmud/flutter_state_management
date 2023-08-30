import 'package:flutter_state_management/objectbox.g.dart';
import 'package:flutter_state_management/src/features/home/data/entities/category_entity.dart';
import 'package:flutter_state_management/src/features/todo/data/entities/todo_entity.dart';

class DatabaseService {
  late final Store store;
  late final Box<CategoryEntity> _categoryBox;
  late final Box<TodoEntity> _todoBox;

  DatabaseService._(this.store) {
    _categoryBox = Box<CategoryEntity>(store);
    _todoBox = Box<TodoEntity>(store);
  }

  static Future<DatabaseService> create() async {
    final store = await openStore();
    return DatabaseService._(store);
  }

  Future<int> addCategory(CategoryEntity categoryEntity) {
    return _categoryBox.putAsync(categoryEntity);
  }

  Future<int> addTodoEntity(TodoEntity todoEntity) {
    return _todoBox.putAsync(todoEntity);
  }

  Future<List<CategoryEntity>> getAllCategories() {
    return _categoryBox.getAllAsync();
  }

  List<CategoryEntity> getTodosByCategory(int categoryId) {
    final query =
        _categoryBox.query(CategoryEntity_.id.equals(categoryId)).build();
    final categories = query.find();
    return categories;
  }

// Stream<List<C>> getAllCategories() {
//   return _categoryBox.getAll();
// }
//
// List<TodoEntity> getAllTodoEntities() {
//   return _todoBox.getAll();
// }
//
// CategoryEntity? getCategory(int id) {
//   return _categoryBox.get(id);
// }
//
// TodoEntity? getTodoEntity(int id) {
//   return _todoBox.get(id);
// }
}
