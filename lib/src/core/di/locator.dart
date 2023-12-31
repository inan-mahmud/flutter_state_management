import 'package:flutter_state_management/objectbox.g.dart';
import 'package:flutter_state_management/src/features/category/data/repositories/category_repository.dart';
import 'package:flutter_state_management/src/features/category/domain/repositories/i_category_repository.dart';
import 'package:flutter_state_management/src/features/category/domain/usecase/create_category_usecase.dart';
import 'package:flutter_state_management/src/features/category/domain/usecase/fetch_category_usecase.dart';
import 'package:flutter_state_management/src/features/important_todos/data/repositories/important_todos_repository.dart';
import 'package:flutter_state_management/src/features/important_todos/domain/repositories/i_important_todos_repository.dart';
import 'package:flutter_state_management/src/features/important_todos/domain/usecases/fetch_important_todos_usecase.dart';
import 'package:flutter_state_management/src/features/tasks/data/repositories/tasks_repository.dart';
import 'package:flutter_state_management/src/features/tasks/domain/repositories/i_tasks_repository.dart';
import 'package:flutter_state_management/src/features/tasks/domain/usecases/add_tasks_usecase.dart';
import 'package:flutter_state_management/src/features/tasks/domain/usecases/fetch_tasks_usecase.dart';
import 'package:flutter_state_management/src/features/todo/data/repositories/todo_repository.dart';
import 'package:flutter_state_management/src/features/todo/domain/repositories/i_todo_repository.dart';
import 'package:flutter_state_management/src/features/todo/domain/usecase/add_todo_by_category_usecase.dart';
import 'package:flutter_state_management/src/features/todo/domain/usecase/fetch_todos_by_category_usecase.dart';
import 'package:flutter_state_management/src/features/todo/domain/usecase/update_todo_usecase.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerLazySingletonAsync<Store>(
    () async {
      return await openStore();
    },
  );

  await locator.isReady<Store>();

  locator.registerSingletonWithDependencies<ICategoryRepository>(
      () => CategoryRepository(),
      dependsOn: [Store]);

  locator.registerFactory<FetchCategoryUseCase>(
    () => FetchCategoryUseCase(
      locator(),
    ),
  );
  locator.registerFactory<CreateCategoryUseCase>(
    () => CreateCategoryUseCase(
      locator(),
    ),
  );

  locator.registerSingletonWithDependencies<ITodoRepository>(
    () => TodoRepository(),
    dependsOn: [Store],
  );

  locator.registerFactory<FetchTodosByCategoryUseCase>(
    () => FetchTodosByCategoryUseCase(
      todoRepository: locator(),
    ),
  );
  locator.registerFactory<AddTodoByCategoryUseCase>(
    () => AddTodoByCategoryUseCase(
      todoRepository: locator(),
    ),
  );
  locator.registerFactory<UpdateTodoUseCase>(
    () => UpdateTodoUseCase(
      todoRepository: locator(),
    ),
  );

  locator.registerSingletonWithDependencies<IImportantTodosRepository>(
      () => ImportantTodosRepository(),
      dependsOn: [Store]);

  locator.registerFactory<FetchImportantTodosUseCase>(
    () => FetchImportantTodosUseCase(
      importantTodosRepository: locator(),
    ),
  );

  locator.registerSingletonWithDependencies<ITasksRepository>(
      () => TaskRepository(),
      dependsOn: [Store]);

  locator.registerFactory<FetchTasksUseCase>(
    () => FetchTasksUseCase(
      tasksRepository: locator(),
    ),
  );
  locator.registerFactory<AddTaskUseCase>(
    () => AddTaskUseCase(
      tasksRepository: locator(),
    ),
  );
}
