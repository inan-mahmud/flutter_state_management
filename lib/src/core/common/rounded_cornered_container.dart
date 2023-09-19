import 'package:flutter/material.dart';

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
          color: Colors.white,
          border: Border.all(
            color: Colors.white,
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
