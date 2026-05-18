import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dart:io';
import 'package:image_picker/image_picker.dart';

class StoryController extends GetxController {
  final RxBool isSoundOn = true.obs;
  final Rx<File?> selectedImage = Rx<File?>(null);
  final RxString selectedCategory = ''.obs;
  final RxString selectedMusic = ''.obs;
  final RxString selectedFilter = 'None'.obs;
  final RxBool isAutoZoom = false.obs;
  final RxBool isEditingDetails = false.obs;
  final RxString storyText = ''.obs;
  final TextEditingController textController = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  void toggleSound() {
    isSoundOn.value = !isSoundOn.value;
  }

  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImage.value = File(image.path);
      isEditingDetails.value = false;
    }
  }

  Future<void> pickImageFromCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      selectedImage.value = File(image.path);
      isEditingDetails.value = false;
    }
  }

  void setCategory(String category) => selectedCategory.value = category;
  void setMusic(String music) => selectedMusic.value = music;

  // Future<void> downloadImage(String imageUrl) async {
  //   try {
  //     var response = await http.get(Uri.parse(imageUrl));
  //     final result = await ImageGallerySaver.saveImage(
  //       Uint8List.fromList(response.bodyBytes),
  //       quality: 100,
  //       name: "un4seen_story_${DateTime.now().millisecondsSinceEpoch}",
  //     );
  //     if (result['isSuccess']) {
  //       Get.snackbar('Success', 'Image saved to gallery');
  //     } else {
  //       Get.snackbar('Error', 'Failed to save image');
  //     }
  //   } catch (e) {
  //     Get.snackbar('Error', 'Failed to download image: $e');
  //   }
  // }
}
