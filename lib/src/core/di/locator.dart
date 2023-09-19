import 'package:flutter_state_management/objectbox.g.dart';
import 'package:flutter_state_management/src/features/home/data/repositories/category_repository.dart';
import 'package:flutter_state_management/src/features/home/domain/usecase/create_category_usecase.dart';
import 'package:flutter_state_management/src/features/home/domain/usecase/fetch_category_usecase.dart';
import 'package:flutter_state_management/src/features/todo/data/repositories/todo_repository.dart';
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

  locator.registerSingletonWithDependencies(() => CategoryRepository(),
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

  locator.registerSingletonWithDependencies(
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
}
