import 'package:flutter/material.dart';

class AppState {
  String? _error;

  String get error => _error ?? '';

  set error(String error) => _error = error;

  bool isLoading = false;
}

class AppStateProvider extends InheritedWidget {
  final AppState appState;

  const AppStateProvider({
    super.key,
    required this.appState,
    required super.child,
  });

  @override
  bool updateShouldNotify(covariant AppStateProvider oldWidget) {
    return appState != oldWidget.appState;
  }

  static AppStateProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppStateProvider>()!;
  }
}
