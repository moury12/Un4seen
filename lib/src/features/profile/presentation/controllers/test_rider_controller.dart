// lib/src/features/profile/presentation/controllers/test_rider_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:un4seen/src/core/core_export.dart';
import '../../../../core/services/api_service.dart';

class TestRiderController extends GetxController {
  final ApiService _api = Get.find<ApiService>();

  final textController = TextEditingController();
  final isLoading = false.obs;

  Future<void> applyForProgram() async {
    if (textController.text.trim().isEmpty) {
      Get.snackbar('Error', 'Please provide application details');
      return;
    }

    try {
      isLoading.value = true;
      final response = await _api.post(
        '/test-rider/apply',
        data: {"applicationText": textController.text.trim()},
      );

      if (response.data['success']) {
        CustomSnackbar.showSuccess(response.data['message']);
        textController.clear();
        // Optional: Navigate back or show success state
      } else {
        CustomSnackbar.showError(response.data['message']);
        textController.clear();
      }
    } catch (e) {
      CustomSnackbar.showError(
        'Failed to submit application. Please try again.',
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    textController.dispose();
    super.onClose();
  }
}
