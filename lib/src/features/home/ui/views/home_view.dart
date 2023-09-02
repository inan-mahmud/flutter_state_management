import 'package:flutter/material.dart';
import 'package:flutter_state_management/src/features/home/ui/inherited_widgets/category_inherited_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      CategoryInheritedWidget
          .of(context)
          .categoriesNotifier
          .fetchCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = CategoryInheritedWidget
        .of(context)
        .categoriesNotifier;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Home'), centerTitle: true),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAdaptiveDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                    title: const Text('Add Category'),
                    content: TextFormField(
                      controller: textController,
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          // viewModel.createCategory(
                          //   CategoryModel(title: textController.text),
                          // );
                          Navigator.pop(context);
                        },
                        child: const Text('Add'),
                      )
                    ]);
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
