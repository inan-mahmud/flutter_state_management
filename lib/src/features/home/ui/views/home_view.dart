import 'package:flutter/material.dart';
import 'package:flutter_state_management/src/core/rounded_cornered_container.dart';
import 'package:flutter_state_management/src/core/route/route_arguments.dart';
import 'package:flutter_state_management/src/core/route/routes.dart';
import 'package:flutter_state_management/src/features/home/domain/models/category_model.dart';
import 'package:flutter_state_management/src/features/home/ui/provider/categories_provider.dart';
import 'package:flutter_state_management/src/features/home/ui/controllers/category_controller.dart';
import 'package:flutter_state_management/src/features/home/ui/state/home_state.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final textController = TextEditingController();

  CategoryController? _categoryController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final controller = CategoriesProvider.of(context).categoryController;
    if (_categoryController != controller) {
      _categoryController = controller;
      _categoryController?.addListener(_onStateChange);
    }
  }

  void _onStateChange() {
    _categoryController?.result.value.maybeWhen(failure: (message) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message),
      ));
    }, success: (id) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Category Created'),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        child: StreamBuilder<List<CategoryModel>>(
          stream: _categoryController?.categoryStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final categories = snapshot.data!;
              return categories.isNotEmpty
                  ? ListView.builder(
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final category = snapshot.data![index];
                        return InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              Routes.todos,
                              arguments: RouteArguments(
                                data: {'id': category.id},
                              ),
                            );
                          },
                          child: RoundedCorneredContainer(
                            child: ListTile(
                              title: Text(
                                category.title,
                              ),
                            ),
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
      floatingActionButton: ValueListenableBuilder<Result>(
        valueListenable: _categoryController!.result,
        builder: (context, value, _) {
          return FloatingActionButton(
            onPressed: () {
              showAdaptiveDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                        title: const Text('Add new Category'),
                        content: TextField(
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
                              _categoryController?.createCategory(
                                textController.text,
                              );
                              textController.clear();
                              Navigator.pop(context);
                            },
                            child: const Text('Create'),
                          ),
                        ]);
                  });
            },
            child: const Icon(Icons.add),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    textController.dispose();
    _categoryController?.removeListener(_onStateChange);
    _categoryController?.dispose();
    super.dispose();
  }
}
