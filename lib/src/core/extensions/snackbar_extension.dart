import 'package:flutter/material.dart';
import 'package:flutter_state_management/src/core/config/app_colors.dart';

extension SnackBarExtension on BuildContext {
  void showSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            color: AppColors.darkBlueColor,
            fontSize: 16,
          ),
        ),
        backgroundColor: AppColors.whiteColor,
        duration: Duration(
          milliseconds: 500,
        ),
      ),
    );
  }
}
