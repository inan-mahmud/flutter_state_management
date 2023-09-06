import 'package:flutter/material.dart';
import 'package:flutter_state_management/src/core/di/locator.dart';
import 'package:flutter_state_management/src/features/home/domain/models/category_model.dart';
import 'package:flutter_state_management/src/features/home/ui/presenters/category_interface.dart';
import 'package:flutter_state_management/src/features/home/ui/presenters/cateogries_notifier.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> implements CategoryInterface {
  final textController = TextEditingController();

  CategoriesPresenter? _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = CategoriesPresenter(
        createCategoryUseCase: locator(),
        fetchCategoryUseCase: locator(),
        categoryInterface: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Home'), centerTitle: true),
      body: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        child: StreamBuilder<List<CategoryModel>>(
          stream: _presenter?.categoryStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final categories = snapshot.data!;
              return categories.isNotEmpty
                  ? ListView.builder(
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final category = snapshot.data![index];
                        return ListTile(
                          title: Text(
                            category.title,
                          ),
                        );
                      },
                    )
                  : const Center(
                      child: Text('No Categories'),
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
                      _presenter?.createCategory(textController.text);
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

  @override
  void dispose() {
    textController.dispose();
    _presenter?.dispose();
    super.dispose();
  }
}
