import 'package:flutter/material.dart';
import 'package:flutter_state_management/src/core/route/route_arguments.dart';

class TodosView extends StatefulWidget {
  const TodosView({super.key});

  @override
  State<TodosView> createState() => _TodosViewState();
}

class _TodosViewState extends State<TodosView> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as RouteArguments;
    
    final id = args.data?['id'] as int?;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Text('Todos $id'),
      ),
    );
  }
}
