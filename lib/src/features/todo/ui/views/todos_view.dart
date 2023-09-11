import 'package:flutter/material.dart';
import 'package:flutter_state_management/src/core/rounded_cornered_container.dart';
import 'package:flutter_state_management/src/core/route/route_arguments.dart';
import 'package:flutter_state_management/src/features/todo/domain/models/todo_model.dart';
import 'package:flutter_state_management/src/features/todo/ui/controllers/todos_controller.dart';
import 'package:flutter_state_management/src/features/todo/ui/provider/todo_provider.dart';

class TodosView extends StatefulWidget {
  final RouteArguments args;
  int? id;

  TodosView({super.key, required this.args}) {
    id = args.data?['id'];
  }

  @override
  State<TodosView> createState() => _TodosViewState();
}

class _TodosViewState extends State<TodosView> {
  TodosController? _todosController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final controller = TodoProvider.of(context).todoController;
    if (_todosController != controller) {
      _todosController = controller;
      // _todosController?.addListener(_onStateChange);
      _todosController?.fetchTodosByCategory(widget.id ?? 0);
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
        child: StreamBuilder<List<TodoModel>>(
          stream: _todosController?.todoStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final todos = snapshot.data!;
              return todos.isNotEmpty
                  ? ListView.builder(
                      itemCount: todos.length,
                      itemBuilder: (context, index) {
                        final todo = snapshot.data![index];
                        return InkWell(
                          onTap: () {
                            // Navigator.pushNamed(
                            //   context,
                            //   Routes.todos,
                            //   arguments: RouteArguments(
                            //     data: {'id': category.id},
                            //   ),
                            // );
                          },
                          child: RoundedCorneredContainer(
                            child: ListTile(
                              title: Text(
                                todo.title,
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : const Center(
                      child: Text('No Todos available'),
                    );
            } else {
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    // _todosController?.removeListener(_onStateChange);
    _todosController?.dispose();
    super.dispose();
  }
}
