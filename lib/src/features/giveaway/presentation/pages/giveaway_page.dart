import 'package:flutter/material.dart';
import '../../../../core/utils/app_strings.dart';

class GiveawayPage extends StatelessWidget {
  const GiveawayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(AppStaticStrings.giveaway),
      ),
    );
  }
}
