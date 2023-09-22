import 'package:flutter/material.dart';
import 'package:flutter_state_management/src/core/base/result.dart';
import 'package:flutter_state_management/src/features/important/ui/controllers/important_todo_controller.dart';
import 'package:flutter_state_management/src/features/important/ui/provider/important_todo_controller_provider.dart';
import 'package:flutter_state_management/src/features/todo/domain/models/todo_model.dart';

class ImportantTodosView extends StatefulWidget {
  const ImportantTodosView({super.key});

  @override
  State<ImportantTodosView> createState() => _ImportantTodosViewState();
}

class _ImportantTodosViewState extends State<ImportantTodosView> {
  ImportantTodoController? _importantTodoController;
  Stream<Result<List<TodoModel>>>? _importantTodosStream;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initController();
    _initTodos();
  }

  void _initController() {
    final controller = ImportantTodoControllerProvider.of(context).controller;
    if (_importantTodoController != controller ||
        _importantTodoController == null) {
      _importantTodoController = controller;
    }
  }

  void _initTodos() {
    _importantTodosStream = _importantTodoController?.fetchImportantTodos();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
