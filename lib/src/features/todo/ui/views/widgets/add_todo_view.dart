import 'package:flutter/material.dart';
import 'package:flutter_state_management/src/features/home/domain/models/category_model.dart';
import 'package:flutter_state_management/src/features/home/ui/provider/category_model_provider.dart';
import 'package:flutter_state_management/src/features/todo/ui/provider/todo_provider.dart';

class AddTodoView extends StatefulWidget {
  const AddTodoView({super.key});

  @override
  State<AddTodoView> createState() => _AddTodoViewState();
}

class _AddTodoViewState extends State<AddTodoView> {
  final todoTitleController = TextEditingController();
  final todoDescriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final todoController = TodoProvider.of(context).todoController;
    final categoryModel = CategoryModelProvider.of(context).categoryModel;

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
              todoController.addTodo(
                categoryModel,
                todoTitleController.text,
                todoDescriptionController.text,
              );
              Navigator.pop(context);
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
