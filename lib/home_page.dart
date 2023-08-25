import 'package:flutter/material.dart';
import 'package:flutter_state_management/routes.dart';
import 'package:flutter_state_management/todo_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final todoNotifier = TodoProvider.of(context).todoNotifier;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Todo App'),
        ),
        body: SizedBox(
          width: double.infinity,
          height: MediaQuery.sizeOf(context).height,
          child: ValueListenableBuilder(
            valueListenable: todoNotifier,
            builder: (context, value, _) {
              return ListView.builder(
                itemCount: todoNotifier.value.length,
                itemBuilder: (context, index) {
                  final todo = todoNotifier.value[index];
                  return Dismissible(
                    key: ValueKey(todo.id),
                    child: ListTile(
                      title: Text(todo.title),
                      subtitle: Text(todo.description),
                    ),
                  );
                },
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, Routes.addTodo);
          },
          child: const Icon(Icons.add),
        ));
  }
}
