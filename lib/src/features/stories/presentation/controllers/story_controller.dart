import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio; // Standardize to Dio
import 'package:image_picker/image_picker.dart';
import 'package:lindi_sticker_widget/lindi_sticker_widget.dart';
import '../../../../core/services/api_service.dart';
import '../../../../core/widgets/custom_snackbar.dart';
import '../../data/models/story_text_item_model.dart';

class StoryController extends GetxController {
  final ApiService _api = Get.find<ApiService>();
  final GlobalKey boundaryKey = GlobalKey();

  final RxBool isLoading = false.obs;
  final RxString loadingStatus = ''.obs; // New: To show specific status

  final RxBool isLiked = false.obs;
  final RxBool isSoundOn = true.obs;
  final Rx<File?> selectedImage = Rx<File?>(null);
  final RxString selectedCategory = 'Bikes'.obs; 
  final RxString selectedMusic = 'None'.obs;
  final RxString selectedFilter = 'None'.obs;
  final RxBool isAutoZoom = false.obs;
  final RxBool isEditingDetails = false.obs;
  final RxBool isPremium = false.obs;

  final TextEditingController textController = TextEditingController();
  final TextEditingController captionController = TextEditingController();
  final RxList<StoryTextItem> textOverlays = <StoryTextItem>[].obs;
  final ImagePicker _picker = ImagePicker();
  late LindiController stickerController;
  @override
  void onInit() {
stickerController = LindiController(
      borderColor: Colors.white,
      icons: [
        LindiStickerIcon(
            icon: Icons.done,
            alignment: Alignment.topRight,
            onTap: () {
              stickerController.selectedWidget!.done();
            }),
        LindiStickerIcon(
            icon: Icons.lock_open,
            lockedIcon: Icons.lock,
            alignment: Alignment.topCenter,
            type: IconType.lock,
            onTap: () {
              stickerController.selectedWidget!.lock();
            }),
        LindiStickerIcon(
            icon: Icons.close,
            alignment: Alignment.topLeft,
            onTap: () {
              stickerController.selectedWidget!.delete();
            }),
        LindiStickerIcon(
            icon: Icons.edit,
            alignment: Alignment.centerLeft,
            onTap: () {
              stickerController.selectedWidget!
                  .edit(const Icon(Icons.star, size: 50, color: Colors.yellow));
            }),
        LindiStickerIcon(
            icon: Icons.layers,
            alignment: Alignment.centerRight,
            onTap: () {
              stickerController.selectedWidget!.stack();
            }),
        LindiStickerIcon(
            icon: Icons.flip,
            alignment: Alignment.bottomLeft,
            onTap: () {
              stickerController.selectedWidget!.flip();
            }),
        LindiStickerIcon(
            icon: Icons.crop_free,
            alignment: Alignment.bottomRight,
            type: IconType.resize),
      ],
    );
    super.onInit();
  }
  void toggleSound() {
    isSoundOn.value = !isSoundOn.value;
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
 // Method to add text using Lindi
  void addTextSticker(String text, Color color) {
    stickerController.add(
      Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: color,
          fontSize: 28,
          fontWeight: FontWeight.bold,
          backgroundColor: Colors.black.withOpacity(0.3),
        ),
      ),
    );
  }
  Future<void> pickImageFromCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      selectedImage.value = File(image.path);
      isEditingDetails.value = false;
    }
  }


  // ── Step 1: Capture the Editor UI ──
  Future<Uint8List?> _capturePngBytes() async {
    try {
      loadingStatus.value = "Generating high-quality image..."; // Status Update
      
      RenderRepaintBoundary boundary = boundaryKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      return byteData?.buffer.asUint8List();
    } catch (e) {
      print("❌ Capture Error: $e");
      return null;
    }
  }

  // ── Step 2: Final API Call ──
  Future<void> createStory() async {
    try {
      isLoading.value = true;

      // 1. Image Generation Phase
      final Uint8List? imageBytes = await _capturePngBytes();
      if (imageBytes == null) {
        CustomSnackbar.showError("Failed to process image");
        return;
      }

      // 2. Upload Phase
      loadingStatus.value = "Uploading to Syndicate..."; // Status Update

      final dataPayload = jsonEncode({
        "contentType": "image",
        "category": selectedCategory.value,
        "caption": captionController.text.trim(),
        "mood": selectedMusic.value,
        "isPremium": isPremium.value,
      });

      dio.FormData formData = dio.FormData.fromMap({
        'image': dio.MultipartFile.fromBytes(
          imageBytes,
          filename: 'story_${DateTime.now().millisecondsSinceEpoch}.png',
        ),
        'data': dataPayload,
      });

      final res = await _api.post('/stories/create', data: formData);

      if (res.data['success'] == true) {
        CustomSnackbar.showSuccess(res.data['message']);
        Get.back(); 
      } else {
        CustomSnackbar.showError(res.data['message']);
      }
    } catch (e) {
      print("❌ Create Story Error: $e");
      CustomSnackbar.showError("Network error. Please try again.");
    } finally {
      isLoading.value = false;
      loadingStatus.value = "";
    }
  }
  // Setters
  void setCategory(String category) => selectedCategory.value = category;
  void setMusic(String music) => selectedMusic.value = music;


}
