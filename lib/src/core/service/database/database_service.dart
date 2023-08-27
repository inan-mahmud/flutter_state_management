// import 'package:flutter_state_management/objectbox.g.dart';
// import 'package:path/path.dart' as p;
// import 'package:path_provider/path_provider.dart';
//
// class DatabaseService {
//   late final Store store;
//   late final Box<CategoryEntity_> categoryBox;
//   late final Box<TodoEntity_> todoBox;
//
//
//   DatabaseService._(this.store);
//
//   static Future<DatabaseService> create() async {
//     final docsDir = await getApplicationDocumentsDirectory();
//     final modelDefinition = getObjectBoxModel();
//     store = await openStore(
//       modelDefinition,
//       directory: p.join(docsDir.path, 'flutter-todo'),
//     );
//   }
// }
