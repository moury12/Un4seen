import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class CustomSnackbar {
  // Add this key to your main.dart MaterialApp
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
        content: Text(message, style: const TextStyle(color: Colors.white)),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
