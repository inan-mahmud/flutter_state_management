import 'package:flutter_state_management/src/features/home/domain/models/category_model.dart';

sealed class HomeState {}

class HomeStateInitial extends HomeState {}

class HomeStateLoading extends HomeState {}

class HomeStateSuccess extends HomeState {
  final List<CategoryModel> categories;

  HomeStateSuccess(this.categories);
}
