import 'package:flutter/material.dart';
import 'package:flutter_state_management/src/core/base/result.dart';
import 'package:flutter_state_management/src/core/common/rounded_cornered_container.dart';
import 'package:flutter_state_management/src/core/config/app_colors.dart';
import 'package:flutter_state_management/src/core/route/routes.dart';
import 'package:flutter_state_management/src/core/utils/constants.dart';
import 'package:flutter_state_management/src/features/category/domain/models/category_model.dart';
import 'package:flutter_state_management/src/features/category/ui/controllers/category_controller.dart';
import 'package:flutter_state_management/src/features/category/ui/provider/categories_provider.dart';

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
      appBar: AppBar(
        title: const Text(
          AppConstants.appName,
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SizedBox(
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ListTile(
                  title: const Text('Important'),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      Routes.important,
                    );
                  },
                ),
                ListTile(
                  title: const Text('Tasks'),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      Routes.tasks,
                    );
                  },
                ),
                StreamBuilder<List<CategoryModel>>(
                  stream: _categoryController?.categoryStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final categories = snapshot.data!;
                      return categories.isNotEmpty
                          ? Column(
                              children: [
                                Visibility(
                                  visible: categories.isNotEmpty,
                                  child: const Divider(
                                    color: AppColors.greyColor,
                                  ),
                                ),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: categories.length,
                                  itemBuilder: (context, index) {
                                    final category = snapshot.data![index];
                                    return InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                          context,
                                          Routes.todos,
                                          arguments: category,
                                        );
                                      },
                                      child: RoundedCorneredContainer(
                                        child: ListTile(
                                          style: Theme.of(context)
                                              .listTileTheme
                                              .style,
                                          title: Text(
                                            category.title,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            )
                          : const Center(
                              child: Text(AppConstants.noCategories),
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
              ],
            ),
          )),
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
                },
              );
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
