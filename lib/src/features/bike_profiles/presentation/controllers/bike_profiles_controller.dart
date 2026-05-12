import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class BikeProfilesController extends GetxController {
  final _imagePicker = ImagePicker();
  
  final Rx<File?> profileImage = Rx<File?>(null);
    Future<void> pickImage() async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1080, // Optimizing resolution
        maxHeight: 1080,
        imageQuality: 85, // Optimizing resolution
      );
      
      if (pickedFile != null) {
        profileImage.value = File(pickedFile.path);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick image: $e');
    }
  }
}
