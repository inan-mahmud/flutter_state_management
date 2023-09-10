import 'package:flutter/material.dart';
import 'package:flutter_state_management/src/features/home/domain/models/category_model.dart';
import 'package:flutter_state_management/src/features/home/ui/inherited_widgets/categories_provider.dart';
import 'package:flutter_state_management/src/features/home/ui/presenters/create_category_notifier.dart';
import 'package:flutter_state_management/src/features/home/ui/state/home_state.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final textController = TextEditingController();
  CreateCategoryNotifier? _createCategoryNotifier;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final notifier =
        CategoriesProvider.of(context).createCategoryNotifier;
    if (_createCategoryNotifier != notifier) {
      _createCategoryNotifier = notifier;
      _createCategoryNotifier?.addListener(_onStateChange);
    }
  }

  void _onStateChange() {
    _createCategoryNotifier?.value.maybeWhen(failure: (message) {
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
    final presenter =
        CategoriesProvider.of(context).categoriesPresenter;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        child: StreamBuilder<List<CategoryModel>>(
          stream: presenter.categoryStream,
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
      floatingActionButton: ValueListenableBuilder<Result>(
        valueListenable: _createCategoryNotifier!,
        builder: (context, value, _) {
          return FloatingActionButton(onPressed: () {
            showAdaptiveDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
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
                            _createCategoryNotifier?.createCategory(
                              textController.text,
                            );
                            textController.clear();
                            Navigator.pop(context);
                          },
                          child: const Text('Create'),
                        ),
                      ]);
                });
          });
        },
      ),
    );
  }

  @override
  void dispose() {
    textController.dispose();
    CategoriesProvider.of(context).categoriesPresenter.dispose();
    _createCategoryNotifier?.removeListener(_onStateChange);
    super.dispose();
  }
}
