import 'package:flutter/material.dart';
import 'package:flutter_state_management/src/core/config/app_colors.dart';

extension SnackBarExtension on BuildContext {
  void showSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: Theme.of(this).textTheme.bodySmall,
        ),
        backgroundColor: AppColors.whiteColor,
      ),
    );
  }
}
