import 'package:flutter/material.dart';
import 'package:flutter_state_management/src/features/todo/ui/provider/todo_list_provider.dart';
import 'package:flutter_state_management/src/features/todo/ui/provider/todo_model_provider.dart';
import 'package:flutter_state_management/src/features/todo/ui/views/widgets/todo_item_view.dart';

class TodoListView extends StatefulWidget {
  const TodoListView({super.key});

  @override
  State<TodoListView> createState() => _TodoListViewState();
}

class _TodoListViewState extends State<TodoListView> {
  final _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final todoList = TodoListProvider.of(context).todoList;
    final completedTodos = todoList.where((element) => element.isDone).toList();
    final inCompletedTodos =
        todoList.where((element) => !element.isDone).toList();

    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: inCompletedTodos.length,
            itemBuilder: (context, index) {
              return TodoModelProvider(
                todoModel: inCompletedTodos[index],
                child: const TodoItemView(),
              );
            },
          ),
          Visibility(
            visible: inCompletedTodos.isNotEmpty && completedTodos.isNotEmpty,
            child: const Divider(),
          ),
          Visibility(
            visible: completedTodos.isNotEmpty,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Completed',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: completedTodos.length,
            itemBuilder: (context, index) {
              return TodoModelProvider(
                todoModel: completedTodos[index],
                child: const TodoItemView(),
              );
            },
          ),
        ],
      ),
    );
  }
}
