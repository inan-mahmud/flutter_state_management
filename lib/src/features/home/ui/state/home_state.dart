import 'package:flutter_state_management/src/features/home/domain/models/category_model.dart';

sealed class HomeState {}

class HomeStateInitial extends HomeState {}

class HomeStateLoading extends HomeState {}

class HomeStateSuccess extends HomeState {
  final List<CategoryModel> categories;

  HomeStateSuccess(this.categories);
}

class HomeStateFailure extends HomeState {
  final String message;

  HomeStateFailure(this.message);
}

extension HomeStateExtensions on HomeState {
  void when({
    required void Function() initial,
    required void Function() loading,
    required void Function(List<CategoryModel> categories) success,
    required void Function(String message) failure,
  }) {
    if (this is HomeStateInitial) {
      initial.call();
    } else if (this is HomeStateLoading) {
      loading.call();
    } else if (this is HomeStateSuccess) {
      success.call((this as HomeStateSuccess).categories);
    } else if (this is HomeStateFailure) {
      failure.call((this as HomeStateFailure).message);
    }
  }

  void maybeWhen({
    void Function()? initial,
    void Function()? loading,
    void Function(List<CategoryModel> categories)? success,
    void Function(String message)? failure,
    void Function()? orElse,
  }) {
    if (this is HomeStateInitial) {
      initial?.call();
    } else if (this is HomeStateLoading) {
      loading?.call();
    } else if (this is HomeStateSuccess) {
      success?.call((this as HomeStateSuccess).categories);
    } else if (this is HomeStateFailure) {
      failure?.call((this as HomeStateFailure).message);
    } else {
      orElse?.call();
    }
  }
}
