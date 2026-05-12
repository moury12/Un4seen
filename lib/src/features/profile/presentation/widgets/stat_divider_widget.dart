import 'package:flutter/material.dart';

class StatDividerWidget extends StatelessWidget {
  const StatDividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 29,
      width: 1,
      color: Colors.black.withValues(alpha: 0.2),
    );
  }
}
