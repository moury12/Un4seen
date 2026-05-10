import 'package:flutter/material.dart';
import '../../../../core/utils/app_strings.dart';

class CompetitionsPage extends StatelessWidget {
  const CompetitionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(AppStaticStrings.competitions),
      ),
    );
  }
}
