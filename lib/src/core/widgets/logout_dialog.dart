import 'package:flutter/material.dart';
import 'package:un4seen/src/core/core_export.dart';
import 'package:get/get.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const LogoutDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text(AppStaticStrings.logoutPopup.tr),
      content: Text(AppStaticStrings.areYouSureLogout.tr),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            AppStaticStrings.no.tr,
            style: const TextStyle(color: AppColors.kSecondaryTextColor),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            // Add logout logic here
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.kRedColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: Text(
            AppStaticStrings.yes.tr,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
