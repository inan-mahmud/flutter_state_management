import 'package:flutter/material.dart';

class TodoFloatingActionButton extends StatelessWidget {
  final Widget widget;

  const TodoFloatingActionButton({
    super.key,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) => widget,
          enableDrag: true,
        );
      },
      child: const Icon(Icons.add),
    );
  }
}
