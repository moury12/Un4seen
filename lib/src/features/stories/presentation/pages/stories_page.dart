import 'package:flutter/material.dart';
import '../../../../core/utils/app_strings.dart';

class StoriesPage extends StatelessWidget {
  const StoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(AppStaticStrings.stories),
      ),
    );
  }
}
