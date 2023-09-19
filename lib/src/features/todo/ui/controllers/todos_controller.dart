import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_state_management/src/features/home/domain/models/category_model.dart';
import 'package:flutter_state_management/src/features/home/ui/state/home_state.dart';
import 'package:flutter_state_management/src/features/todo/domain/models/todo_model.dart';
import 'package:flutter_state_management/src/features/todo/domain/usecase/add_todo_by_category_usecase.dart';
import 'package:flutter_state_management/src/features/todo/domain/usecase/fetch_todos_by_category_usecase.dart';
import 'package:flutter_state_management/src/features/todo/domain/usecase/update_todo_usecase.dart';

class TodosController extends ChangeNotifier {
  final FetchTodosByCategoryUseCase fetchTodosByCategoryUseCase;
  final AddTodoByCategoryUseCase addTodoByCategoryUseCase;
  final UpdateTodoUseCase updateTodoUseCase;

  Result<int> todoResult = Init();
  Result<int> updateTodoResult = Init();

  ValueNotifier<Result<List<TodoModel>>> todos = ValueNotifier(Init());

  TodosController({
    required this.fetchTodosByCategoryUseCase,
    required this.addTodoByCategoryUseCase,
    required this.updateTodoUseCase,
  });

  Stream<Result<List<TodoModel>>> fetchTodosByCategory(int id) async* {
    yield* fetchTodosByCategoryUseCase.fetchTodosStreamByCategory(id).fold(
      (failure) async* {
        yield Error(failure.message);
      },
      (stream) async* {
        yield* stream.map((todos) => Success(todos));
      },
    );
  }

  void addTodo(CategoryModel model, String title, String description) {
    final result =
        addTodoByCategoryUseCase.addTodoByCategory(model, title, description);
    result.fold((failure) {
      todoResult = Error(failure.message);
      notifyListeners();
    }, (id) {
      todoResult = Success(id);
      notifyListeners();
    });
  }

  void updateTodo(TodoModel todoModel) {
    final result = updateTodoUseCase.updateTodo(todoModel);

    result.fold((failure) {
      updateTodoResult = Error(failure.message);
      notifyListeners();
    }, (id) {
      updateTodoResult = Success(id);
      notifyListeners();
    });
  }
}
