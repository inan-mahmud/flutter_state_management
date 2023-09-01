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
  R when<R extends Object?>({
    required R Function() initial,
    required R Function() loading,
    required R Function(List<CategoryModel> categories) success,
    required R Function(String message) failure,
  }) {
    if (this is HomeStateInitial) {
      return initial.call();
    } else if (this is HomeStateLoading) {
      return loading.call();
    } else if (this is HomeStateSuccess) {
      return success.call((this as HomeStateSuccess).categories);
    } else if (this is HomeStateFailure) {
      return failure.call((this as HomeStateFailure).message);
    } else {
      return initial.call();
    }
  }

  R? maybeWhen<R extends Object?>({
    R? Function()? initial,
    R? Function()? loading,
    R? Function(List<CategoryModel> categories)? success,
    R? Function(String message)? failure,
    R? Function()? orElse,
  }) {
    if (this is HomeStateInitial) {
      return initial?.call();
    } else if (this is HomeStateLoading) {
      return loading?.call();
    } else if (this is HomeStateSuccess) {
      return success?.call((this as HomeStateSuccess).categories);
    } else if (this is HomeStateFailure) {
      return failure?.call((this as HomeStateFailure).message);
    } else {
      return orElse?.call();
    }
  }
}
