import 'package:flutter/material.dart';

extension RouteExtension on BuildContext {
  toNamed(String routeName, {Object? arguments}) {
    Navigator.of(this).pushNamed(routeName, arguments: arguments);
  }

  toNamedAndRemoveUntil(String routeName, {Object? arguments}) {
    Navigator.of(this).pushNamedAndRemoveUntil(routeName, (route) => false,
        arguments: arguments);
  }

  goBackUntil(String routeName, {Object? arguments}) {
    Navigator.of(this).popUntil((route) => route.settings.name == routeName);
  }

  goBack() {
    Navigator.of(this).pop();
  }
}
