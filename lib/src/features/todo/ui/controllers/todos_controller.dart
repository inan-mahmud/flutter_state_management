import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_state_management/src/features/todo/domain/models/todo_model.dart';
import 'package:flutter_state_management/src/features/todo/domain/usecase/fetch_todos_by_category_usecase.dart';

class TodosController extends ChangeNotifier {
  final _todoStreamController = StreamController<List<TodoModel>>();

  Stream<List<TodoModel>> get todoStream => _todoStreamController.stream;

  final FetchTodosByCategoryUseCase fetchTodosByCategoryUseCase;

  TodosController({
    required this.fetchTodosByCategoryUseCase,
  });

  void fetchTodosByCategory(int id) {
    fetchTodosByCategoryUseCase.fetchTodosStreamByCategory(id).fold(
      (failure) {
        _todoStreamController.addError(failure.message);
      },
      (stream) {
        stream.listen((todos) {
          _todoStreamController.add(todos);
        });
      },
    );
  }
}
