import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class StoryController extends GetxController {
  final RxBool isSoundOn = true.obs;
  final RxBool isLiked = false.obs;
  final Rx<File?> selectedImage = Rx<File?>(null);
  final Rxn<Uint8List> editedImageBytes = Rxn<Uint8List>();
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
// / Inside your StoryController class
Future<void> updateImageFromBytes(Uint8List bytes) async {
  try {
    final tempDir = await getTemporaryDirectory();
    final file = await File(
            '${tempDir.path}/edited_story_${DateTime.now().millisecondsSinceEpoch}.png')
        .create();
    await file.writeAsBytes(bytes);
    selectedImage.value = file;
  } catch (e) {
    debugPrint("Error saving edited image: $e");
  }
}
  void toggleLike() {
    isLiked.value = !isLiked.value;
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
// Future<void> createStory() async {
//     try {
//       isLoading.value = true;

//       // 1. Image Generation Phase
//       final Uint8List? imageBytes = await _capturePngBytes();
//       if (imageBytes == null) {
//         CustomSnackbar.showError("Failed to process image");
//         return;
//       }

//       // 2. Upload Phase
//       loadingStatus.value = "Uploading to Syndicate..."; // Status Update

//       final dataPayload = jsonEncode({
//         "contentType": "image",
//         "category": selectedCategory.value,
//         "caption": captionController.text.trim(),
//         "mood": selectedMusic.value,
//         "isPremium": isPremium.value,
//       });

//       dio.FormData formData = dio.FormData.fromMap({
//         'image': dio.MultipartFile.fromBytes(
//           imageBytes,
//           filename: 'story_${DateTime.now().millisecondsSinceEpoch}.png',
//         ),
//         'data': dataPayload,
//       });

//       final res = await _api.post('/stories/create', data: formData);

//       if (res.data['success'] == true) {
//         CustomSnackbar.showSuccess(res.data['message']);
//         Get.back(); 
//       } else {
//         CustomSnackbar.showError(res.data['message']);
//       }
//     } catch (e) {
//       print("❌ Create Story Error: $e");
//       CustomSnackbar.showError("Network error. Please try again.");
//     } finally {
//       isLoading.value = false;
//       loadingStatus.value = "";
//     }
//   }
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
