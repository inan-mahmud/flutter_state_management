import 'package:flutter/material.dart';
import 'package:flutter_state_management/src/core/rounded_cornered_container.dart';
import 'package:flutter_state_management/src/features/home/domain/models/category_model.dart';
import 'package:flutter_state_management/src/features/home/ui/state/home_state.dart';
import 'package:flutter_state_management/src/features/todo/domain/models/todo_model.dart';
import 'package:flutter_state_management/src/features/todo/ui/controllers/todos_controller.dart';
import 'package:flutter_state_management/src/features/todo/ui/provider/todo_provider.dart';
import 'package:flutter_state_management/src/features/todo/ui/views/widgets/add_todo_view.dart';

class TodosView extends StatefulWidget {
  const TodosView({super.key});

  @override
  State<TodosView> createState() => _TodosViewState();
}

class _TodosViewState extends State<TodosView> {
  TodosController? _todosController;
  Stream<Result<List<TodoModel>>>? todoStream = const Stream.empty();

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
    final categoryModel =
        ModalRoute.of(context)!.settings.arguments as CategoryModel;
    todoStream = _todosController?.fetchTodosByCategory(categoryModel);
    _todosController?.addListener(_onStateChange);
  }

  void _onStateChange() {
    if (mounted) {
      _todosController?.todoResult.maybeWhen(failure: (message) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(message),
        ));
      }, success: (id) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Todo Added'),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        child: StreamBuilder<Result<List<TodoModel>>>(
          stream: todoStream,
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
                      ? ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return RoundedCorneredContainer(
                              child: Text(data[index].title),
                            );
                          },
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) => const AddTodoView(),
            enableDrag: true,
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
