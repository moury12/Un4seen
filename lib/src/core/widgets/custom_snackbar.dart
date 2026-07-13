import 'package:flutter/material.dart';
import 'package:get/get.dart'; // 1. Added GetX Import
import '../theme/app_colors.dart';

class CustomSnackbar {
  // You can safely remove messengerKey from here and your MaterialApp if you aren't using it elsewhere
  
  static void showSuccess(String message) {
    _show(message, AppColors.kGreenColor);
  }

  static void showError(String message) {
    _show(message, AppColors.kRedColor);
  }

  static void _show(String message, Color color) {
    Get.rawSnackbar(
      messageText: Text(
        message, 
        style: const TextStyle(color: Colors.white, fontSize: 14),
      ),
      backgroundColor: color,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(12),
      borderRadius: 8,
      duration: const Duration(seconds: 3),
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }
}