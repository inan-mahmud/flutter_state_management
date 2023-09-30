import 'package:flutter/material.dart';
import 'package:flutter_state_management/src/core/base/result.dart';
import 'package:flutter_state_management/src/core/utils/constants.dart';
import 'package:flutter_state_management/src/features/important_todos/ui/controllers/important_todo_controller.dart';
import 'package:flutter_state_management/src/features/important_todos/ui/provider/important_todo_controller_provider.dart';
import 'package:flutter_state_management/src/features/todo/domain/models/todo_model.dart';
import 'package:flutter_state_management/src/features/todo/ui/provider/todo_list_provider.dart';
import 'package:flutter_state_management/src/features/todo/ui/views/widgets/todo_list_view.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.appName),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: StreamBuilder<Result<List<TodoModel>>>(
          stream: _importantTodosStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final result = snapshot.data!;
              return result.when(
                initial: () {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
                loading: () {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
                success: (data) {
                  return TodoListProvider(
                    todoList: data,
                    child: const TodoListView(),
                  );
                },
                failure: (message) {
                  return Center(
                    child: Text(message),
                  );
                },
              );
            } else {
              return const Center(child: Text('No Todos'));
            }
          },
        ),
      ),
    );
  }
}
