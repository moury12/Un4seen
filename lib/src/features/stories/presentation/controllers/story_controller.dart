import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

class StoryController extends GetxController {
  final RxBool isSoundOn = true.obs;

  void toggleSound() {
    isSoundOn.value = !isSoundOn.value;
  }

  Future<void> downloadImage(String imageUrl) async {
    try {
      var response = await http.get(Uri.parse(imageUrl));
      final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(response.bodyBytes),
        quality: 100,
        name: "un4seen_story_${DateTime.now().millisecondsSinceEpoch}",
      );
      if (result['isSuccess']) {
        Get.snackbar('Success', 'Image saved to gallery');
      } else {
        Get.snackbar('Error', 'Failed to save image');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to download image: $e');
    }
  }
}
