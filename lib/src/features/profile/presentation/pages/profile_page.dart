import 'package:flutter/material.dart';
import '../../../../core/utils/app_strings.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(AppStaticStrings.profile),
      ),
    );
  }
}
