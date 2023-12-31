import 'package:flutter/material.dart';
import 'package:flutter_state_management/src/core/base/result.dart';
import 'package:flutter_state_management/src/core/common/todo_floating_action_button.dart';
import 'package:flutter_state_management/src/core/extensions/route_extension.dart';
import 'package:flutter_state_management/src/core/extensions/snackbar_extension.dart';
import 'package:flutter_state_management/src/core/utils/constants.dart';
import 'package:flutter_state_management/src/features/category/domain/models/category_model.dart';
import 'package:flutter_state_management/src/features/category/ui/provider/category_model_provider.dart';
import 'package:flutter_state_management/src/features/todo/domain/models/todo_model.dart';
import 'package:flutter_state_management/src/features/todo/ui/controllers/todos_controller.dart';
import 'package:flutter_state_management/src/features/todo/ui/provider/todo_list_provider.dart';
import 'package:flutter_state_management/src/features/todo/ui/provider/todo_provider.dart';
import 'package:flutter_state_management/src/features/todo/ui/views/widgets/add_todo_view.dart';
import 'package:flutter_state_management/src/features/todo/ui/views/widgets/todo_list_view.dart';

class TodosView extends StatefulWidget {
  const TodosView({super.key});

  @override
  State<TodosView> createState() => _TodosViewState();
}

class _TodosViewState extends State<TodosView> {
  TodosController? _todosController;
  Stream<Result<List<TodoModel>>>? _todoStream;
  late CategoryModel _categoryModel;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initController();
  }

  void _initController() {
    final controller = TodoProvider.of(context).todoController;
    if (_todosController != controller || _todosController == null) {
      _todosController = controller;
      _fetchTodoAndListenToChange();
    }
  }

  void _fetchTodoAndListenToChange() {
    _categoryModel =
        ModalRoute.of(context)!.settings.arguments as CategoryModel;
    _todoStream = _todosController?.fetchTodosByCategory(_categoryModel.id!);
    _todosController?.addListener(_onUpdateTodoStateChange);
  }

  void _onUpdateTodoStateChange() {
    if (mounted) {
      _todosController?.updateTodoResult.maybeWhen(failure: (message) {
        context.showSnackBar(message);
      }, success: (id) {
        context.showSnackBar(AppConstants.todoUpdated);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Todos'),
          centerTitle: true,
          automaticallyImplyLeading: true,
        ),
        body: SizedBox(
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
          child: StreamBuilder<Result<List<TodoModel>>>(
            stream: _todoStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return snapshot.data!.when(
                  initial: () {
                    return const SizedBox();
                  },
                  loading: () {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                  success: (List<TodoModel> data) {
                    return data.isNotEmpty
                        ? CategoryModelProvider(
                            categoryModel: _categoryModel,
                            child: TodoListProvider(
                              todoList: data,
                              child: const TodoListView(),
                            ),
                          )
                        : const Center(
                            child: Text('No todos'),
                          );
                  },
                  failure: (String message) {
                    return Center(
                      child: Text(message),
                    );
                  },
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
        floatingActionButton: TodoFloatingActionButton(
          widget: CategoryModelProvider(
            categoryModel: _categoryModel,
            child: AddTodoView(
              onAddTodo: (title, description) {
                _todosController?.addTodo(_categoryModel, title, description);
                context.goBack();
              },
            ),
          ),
        ));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
