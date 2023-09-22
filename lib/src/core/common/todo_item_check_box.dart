import 'package:flutter/material.dart';
import 'package:flutter_state_management/src/core/config/app_colors.dart';

class TodoItemCheckBox extends StatelessWidget {
  final bool isChecked;
  final ValueChanged<bool?> onChanged;

  const TodoItemCheckBox(
      {super.key, required this.isChecked, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      checkColor: AppColors.blackColor,
      fillColor: MaterialStateProperty.all(
          isChecked ? AppColors.purpleColor : Colors.white),
      value: isChecked,
      onChanged: onChanged,
    );
  }
}
