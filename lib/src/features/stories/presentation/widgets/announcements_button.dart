import 'package:flutter/material.dart';
import 'package:un4seen/src/core/core_export.dart';
import 'package:get/get.dart';

class AnnouncementsButton extends StatelessWidget {
  const AnnouncementsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.kPrimaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        AppStaticStrings.announcements.tr,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
