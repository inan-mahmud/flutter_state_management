import 'package:flutter/material.dart';
import 'package:flutter_state_management/src/features/home/ui/state/home_state.dart';

class CategoriesNotifier extends ValueNotifier<HomeState> {

  CategoriesNotifier() : super(HomeStateInitial());
}
