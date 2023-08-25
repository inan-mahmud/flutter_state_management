import 'package:flutter/material.dart';
import 'package:flutter_state_management/todo.dart';
import 'package:flutter_state_management/todo_provider.dart';

class AddTodoPage extends StatelessWidget {
  AddTodoPage({super.key});

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final todoNotifier = TodoProvider.of(context).todoNotifier;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Todo'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(
              labelText: 'Title',
            ),
          ),
          TextField(
            controller: _descriptionController,
            decoration: const InputDecoration(
              labelText: 'Description',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              todoNotifier.add(
                    Todo(
                      title: _titleController.text,
                      description: _descriptionController.text,
                    ),
                  );
              Navigator.of(context).pop();
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
