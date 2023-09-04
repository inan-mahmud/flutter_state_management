import 'package:flutter/material.dart';
import 'package:flutter_state_management/src/features/home/domain/models/category_model.dart';
import 'package:flutter_state_management/src/features/home/ui/inherited_widgets/category_controller_provider.dart';
import 'package:flutter_state_management/src/features/home/ui/presenters/category_interface.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> implements CategoryInterface {
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      CategoryControllerProvider.of(context)
          .categoriesNotifier
          .fetchCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    final model = CategoryControllerProvider.of(context).categoriesNotifier;
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
                    ),
                  );
                },
              );
            } else {
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }
          },
        ),
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
                      model.createCategory(textController.text);
                      Navigator.pop(context);
                    },
                    child: const Text('Add'),
                  )
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void onCreateCategoryFailure(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  void onCreateCategorySuccess() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Category Added Successfully'),
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
