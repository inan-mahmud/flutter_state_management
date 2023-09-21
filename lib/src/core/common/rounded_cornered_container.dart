import 'package:flutter/material.dart';
import 'package:flutter_state_management/src/core/config/app_colors.dart';

@immutable
class RoundedCorneredContainer extends StatelessWidget {
  final Widget child;

  const RoundedCorneredContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.lightBlueColor,
          border: Border.all(
            color: AppColors.lightBlueColor,
          ),
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
        child: child,
      ),
    );
  }
}
