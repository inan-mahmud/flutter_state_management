import 'package:flutter_state_management/objectbox.g.dart';
import 'package:flutter_state_management/src/features/home/data/entities/category_entity.dart';
import 'package:flutter_state_management/src/features/todo/data/entities/todo_entity.dart';

class DatabaseService {
  late final Store store;

  late final Box<CategoryEntity> _categoryBox;
  late final Box<TodoEntity> _todoBox;

  DatabaseService
      ._(this.store) {
    _categoryBox = Box<CategoryEntity>(store);
    _todoBox = Box<TodoEntity>(store);
  }

  static Future<DatabaseService> create() async {
    final store = await openStore();
    return DatabaseService._(store);
  }

  int addCategory(CategoryEntity categoryEntity) {
    return _categoryBox.put(categoryEntity);
  }

  int addTodoEntity(TodoEntity todoEntity) {
    return _todoBox.put(todoEntity);
  }

  List<CategoryEntity> fetchCategories() {
    return _categoryBox.getAll();
  }

  List<TodoEntity> fetchTodosByCategory(int categoryId) {
    final queryBuilder = _todoBox.query();
    queryBuilder.link(
        TodoEntity_.category, CategoryEntity_.id.equals(categoryId));
    final query = queryBuilder.build();
    return query.find();
  }

  int updateCategoryEntity(CategoryEntity categoryEntity){
    return _categoryBox.put(categoryEntity);
  }

  int updateTodoEntity(TodoEntity todoEntity) {
    return _todoBox.put(todoEntity);
  }
}
