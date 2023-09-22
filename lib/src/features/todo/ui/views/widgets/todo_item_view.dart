import 'package:flutter/material.dart';
import 'package:flutter_state_management/src/core/common/rounded_cornered_container.dart';
import 'package:flutter_state_management/src/core/common/todo_item_check_box.dart';
import 'package:flutter_state_management/src/core/config/app_colors.dart';
import 'package:flutter_state_management/src/features/todo/ui/provider/todo_model_provider.dart';
import 'package:flutter_state_management/src/features/todo/ui/provider/todo_provider.dart';

class TodoItemView extends StatefulWidget {
  const TodoItemView({super.key});

  @override
  State<TodoItemView> createState() => _TodoItemViewState();
}

class _TodoItemViewState extends State<TodoItemView> {
  @override
  Widget build(BuildContext context) {
    final todoModel = TodoModelProvider.of(context).todoModel;
    bool isImportant = todoModel.isImportant;

    return RoundedCorneredContainer(
      child: ListTile(
        title: Text(
          todoModel.title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            decoration: todoModel.isDone
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),
        subtitle: Text(
          todoModel.description,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        trailing: TodoItemCheckBox(
          isChecked: todoModel.isDone,
          onChanged: (value) {
            final model = todoModel.copyWith(isDone: value);
            TodoProvider.of(context).todoController.updateTodo(model);
          },
        ),
        leading: IconButton(
          icon: todoModel.isImportant
              ? const Icon(
                  Icons.star,
                  color: AppColors.purpleColor,
                )
              : const Icon(
                  Icons.star_border,
                  color: AppColors.purpleColor,
                ),
          onPressed: () {
            setState(() {
              isImportant = !isImportant;
            });
            final model =
                todoModel.copyWith(isImportant: !todoModel.isImportant);
            TodoProvider.of(context).todoController.updateTodo(model);
          },
        ),
      ),
    );
  }
}
