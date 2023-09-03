import 'package:flutter/material.dart';
import 'package:flutter_state_management/src/features/home/domain/models/category_model.dart';
import 'package:flutter_state_management/src/features/home/ui/inherited_widgets/category_controller_model.dart';
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
     // CategoryInheritedWidget.of(context).categoriesNotifier.fetchCategories();
      CategoryControllerModel.of(context).categoriesNotifier.fetchCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
   // final viewModel = CategoryInheritedWidget.of(context).categoriesNotifier;

    final model = CategoryControllerModel.of(context).categoriesNotifier;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Home'), centerTitle: true),
      body: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        child: StreamBuilder<List<CategoryModel>>(
            stream: model.categoryStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final categories = snapshot.data!;
                return ListView.builder(
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final category = snapshot.data![index];
                      return ListTile(
                          title: Text(
                        category.title,
                      ));
                    });
              } else {
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }
            }),
      ),
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
                          //viewModel.createCategory(textController.text);
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

/**
 *  viewModel.categories.isNotEmpty
    ? ListView.builder(
    itemCount: viewModel.categories.length,
    itemBuilder: (context, index) {
    final category = viewModel.categories[index];
    return ListTile(
    title: Text(
    category.title,
    ));
    },
    )
    : const Center(
    child: Text('No Categories'),
    ),
 */
