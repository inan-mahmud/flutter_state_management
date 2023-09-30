import 'package:flutter/material.dart';
import 'package:flutter_state_management/src/core/utils/typedefs.dart';

class AddTodoView extends StatefulWidget {
  final AddTodoCallback onAddTodo;

  const AddTodoView({super.key, required this.onAddTodo});

  @override
  State<AddTodoView> createState() => _AddTodoViewState();
}

class _AddTodoViewState extends State<AddTodoView> {
  final todoTitleController = TextEditingController();
  final todoDescriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: todoTitleController,
            decoration: const InputDecoration(
              hintText: 'Enter Todo',
              hintStyle: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          TextField(
            controller: todoDescriptionController,
            decoration: const InputDecoration(
              hintText: 'Enter Description',
              hintStyle: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          ElevatedButton(
            onPressed: () {
              widget.onAddTodo(
                  todoTitleController.text, todoDescriptionController.text);
            },
            child: const Text('Add'),
          ),
          const SizedBox(
            height: 24,
          ),
        ],
      ),
    );
  }
}
