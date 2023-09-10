import 'package:flutter/widgets.dart';
import 'package:flutter_state_management/src/features/home/domain/usecase/create_category_usecase.dart';
import 'package:flutter_state_management/src/features/home/ui/state/home_state.dart';

class CreateCategoryNotifier extends ValueNotifier<Result> {
  final CreateCategoryUseCase createCategoryUseCase;

  CreateCategoryNotifier({required this.createCategoryUseCase}) : super(Init());

  void createCategory(String categoryName) {
    createCategoryUseCase.createCategory(categoryName).fold((failure) {
      value = Error(failure.message);
    }, (id) {
      value = Success(id);
    });
  }
}
