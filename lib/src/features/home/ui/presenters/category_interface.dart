import 'package:flutter_state_management/src/features/home/domain/models/category_model.dart';

abstract interface class CategoryInterface {
  void onCreateCategorySuccess();

  void onCreateCategoryFailure(String message);
}
