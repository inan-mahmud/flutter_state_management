import 'package:flutter/material.dart';
import 'package:flutter_state_management/src/features/todo/domain/models/todo_model.dart';

class TodoModelProvider extends InheritedWidget {
  final TodoModel todoModel;

  TodoModelProvider({super.key, required super.child, required this.todoModel});

  @override
  bool updateShouldNotify(covariant TodoModelProvider oldWidget) {
    return todoModel != oldWidget.todoModel;
  }

  static TodoModelProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TodoModelProvider>()!;
  }
}

class _ModelBindingScope<T> extends InheritedWidget {
  const _ModelBindingScope(
      {Key? key, required this.modelBindingState, required Widget child})
      : super(key: key, child: child);

  final _ModelBindingState<T> modelBindingState;

  @override
  bool updateShouldNotify(_ModelBindingScope oldWidget) => true;
}

class ModelBinding<T> extends StatefulWidget {
  const ModelBinding({
    Key? key,
    @required this.initialModel,
    required this.child,
  })  : assert(initialModel != null),
        super(key: key);

  final T? initialModel;
  final Widget child;

  @override
  _ModelBindingState<T> createState() => _ModelBindingState<T>();

  static T of<T>(BuildContext context) {
    final scope =
        context.dependOnInheritedWidgetOfExactType<_ModelBindingScope>();
    return scope?.modelBindingState.currentModel;
  }

  static void update<T>(BuildContext context, T newModel) {
    final scope =
        context.dependOnInheritedWidgetOfExactType<_ModelBindingScope>();
    scope?.modelBindingState.updateModel(newModel);
  }
}

class _ModelBindingState<T> extends State<ModelBinding<T>> {
  late T currentModel;

  @override
  void initState() {
    super.initState();
    currentModel = widget.initialModel as T;
  }

  void updateModel(T newModel) {
    if (newModel != currentModel) {
      setState(() {
        currentModel = newModel;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _ModelBindingScope<T>(
      modelBindingState: this,
      child: widget.child,
    );
  }
}
