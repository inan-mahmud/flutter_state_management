import 'package:flutter/material.dart';
import 'package:flutter_state_management/src/features/home/data/repositories/home_repository.dart';
import 'package:flutter_state_management/src/features/home/domain/usecase/fetch_category_usecase.dart';
import 'package:flutter_state_management/src/features/home/ui/notifiers/cateogries_notifier.dart';
import 'package:flutter_state_management/src/features/home/ui/state/home_state.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final CategoriesNotifier categoriesNotifier =
      CategoriesNotifier(FetchCategoryUseCase(HomeRepository()));

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      categoriesNotifier.fetchCategories();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Home'), centerTitle: true),
      body: ValueListenableBuilder(
        valueListenable: categoriesNotifier,
        builder: (context, state, child) {
          return state.when(initial: () {
            return const SizedBox();
          }, loading: () {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }, success: (categories) {
            return categories.isNotEmpty
                ? ListView.builder(
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return Text(categories[index].title);
                    },
                  )
                : const Center(
                    child: Text(
                        "No categories or todos found, you can create new categories or todos from the bottom right button,"),
                  );
          }, failure: (message) {
            return const SizedBox();
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
