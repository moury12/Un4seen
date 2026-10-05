import 'package:flutter/material.dart';
import 'package:get/get.dart'; // 1. Added GetX Import
import '../theme/app_colors.dart';

class CustomSnackbar {
  static final GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();
  static void showSuccess(String message) {
    _show(message, AppColors.kGreenColor);
  }

  static void showError(String message) {
    _show(message, AppColors.kRedColor);
  }

  static void _show(String message, Color color) {
    messengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white, fontSize: 14),
        ),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
