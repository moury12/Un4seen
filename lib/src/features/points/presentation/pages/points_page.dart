import 'package:flutter/material.dart';
import '../../../../core/utils/app_strings.dart';

class PointsPage extends StatelessWidget {
  const PointsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(AppStaticStrings.points),
      ),
    );
  }
}
