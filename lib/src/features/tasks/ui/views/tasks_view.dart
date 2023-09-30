import 'package:flutter/material.dart';
import 'package:flutter_state_management/src/core/base/result.dart';
import 'package:flutter_state_management/src/core/common/todo_floating_action_button.dart';
import 'package:flutter_state_management/src/core/config/app_colors.dart';
import 'package:flutter_state_management/src/core/extensions/route_extension.dart';
import 'package:flutter_state_management/src/core/extensions/snackbar_extension.dart';
import 'package:flutter_state_management/src/core/utils/constants.dart';
import 'package:flutter_state_management/src/features/tasks/ui/controllers/tasks_controller.dart';
import 'package:flutter_state_management/src/features/tasks/ui/provider/tasks_provider.dart';
import 'package:flutter_state_management/src/features/todo/domain/models/todo_model.dart';
import 'package:flutter_state_management/src/features/todo/ui/provider/todo_list_provider.dart';
import 'package:flutter_state_management/src/features/todo/ui/views/widgets/add_todo_view.dart';
import 'package:flutter_state_management/src/features/todo/ui/views/widgets/todo_list_view.dart';

class TaskView extends StatefulWidget {
  const TaskView({super.key});

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  TasksController? _tasksController;
  Stream<Result<List<TodoModel>>>? _taskStream;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initController();
    _initTodos();
  }

  void _initController() {
    final controller = TasksControllerProvider.of(context).controller;
    if (_tasksController != controller || _tasksController == null) {
      _tasksController = controller;
      _tasksController?.addListener(_onStateChange);
    }
  }

  void _initTodos() {
    _taskStream = _tasksController?.fetchTasks();
  }

  void _onStateChange() {
    if (mounted) {
      _tasksController?.todoResult.maybeWhen(
        failure: (message) {
          context.showSnackBar(message);
        },
        success: (id) {
          context.showSnackBar(AppConstants.taskAdded);
        },
      );
    }
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
          stream: _taskStream,
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
                  if (data.isNotEmpty) {
                    return TodoListProvider(
                      todoList: data,
                      child: const TodoListView(),
                    );
                  } else {
                    return const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Center(
                        child: Text(
                          AppConstants.noTasks,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ),
                    );
                  }
                },
                failure: (message) {
                  return Center(
                    child: Text(message),
                  );
                },
              );
            } else {
              return const Center(
                child: Text(
                  AppConstants.noTasks,
                  style: TextStyle(
                    color: AppColors.whiteColor,
                  ),
                ),
              );
            }
          },
        ),
      ),
      floatingActionButton: TodoFloatingActionButton(
        widget: AddTodoView(
          onAddTodo: (title, description) {
            _tasksController?.addTodo(title, description);
            context.goBack();
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tasksController?.removeListener(_onStateChange);
    _tasksController?.dispose();
    super.dispose();
  }
}
