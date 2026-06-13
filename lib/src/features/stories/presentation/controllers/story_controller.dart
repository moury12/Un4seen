import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:un4seen/src/core/core_export.dart';
import 'package:un4seen/src/core/services/api_service.dart';
import 'package:un4seen/src/core/services/socket_service.dart';
import 'package:un4seen/src/features/stories/data/models/music_model.dart';
import 'package:un4seen/src/features/stories/data/models/story_model.dart';

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
  final Rxn<MusicModel> selectedMusicModel = Rxn<MusicModel>();
  final TextEditingController textController = TextEditingController();
  final GlobalKey boundaryKey = GlobalKey();
  final ApiService _api = Get.find<ApiService>();
  final RxString selectedMusicName = 'None'.obs;
  final RxString selectedMusicId = ''.obs;
  final RxBool isLoading = false.obs;
  final RxString loadingStatus = ''.obs;
  final ImagePicker _picker = ImagePicker();
    final RxList<StoryModel> stories = <StoryModel>[].obs;
  final RxBool isStoriesLoading = false.obs;

  final List<String> categories = [
    'Bikes',
    'Orders',
    'Installs',
    'Winners',
    'Behind Scenes',
  ];

  void toggleSound() {
    isSoundOn.value = !isSoundOn.value;
  }
@override
  void onInit() {
    super.onInit();
    fetchStories();
      setupSocket();

  }
  void setupSocket() {
    final socketService = Get.put(SocketService());
    socketService.initSocket();
    
    socketService.listenToEvent('NEW_STORY', (data) {
      log("🔔 New Story received via Socket");
      final newStory = StoryModel.fromJson(data);
      stories.insert(0, newStory); // Add to top of list
    });
  }
  // / Inside your StoryController class
  Future<void> updateImageFromBytes(Uint8List bytes) async {
    try {
      final tempDir = await getTemporaryDirectory();
      final file = await File(
        '${tempDir.path}/edited_story_${DateTime.now().millisecondsSinceEpoch}.png',
      ).create();
      await file.writeAsBytes(bytes);
      selectedImage.value = file;
    } catch (e) {
      debugPrint("Error saving edited image: $e");
    }
  }

  void toggleLike() {
    isLiked.value = !isLiked.value;
  }
Future<void> fetchStories() async {
    try {
      isStoriesLoading.value = true;
      final res = await _api.get('/stories');
      if (res.data['success']) {
        final List data = res.data['data'];
        stories.assignAll(data.map((e) => StoryModel.fromJson(e)).toList());
      }
    } finally {
      isStoriesLoading.value = false;
    }
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
  // ── Create Story API Call (No Caption) ──
  Future<bool> createStory() async {
    try {
      isLoading.value = true;

      if (selectedImage.value == null) {
        CustomSnackbar.showError("Please select an image");
        return false;
      }

      final Uint8List imageBytes = await selectedImage.value!.readAsBytes();

      loadingStatus.value = "Uploading to Syndicate...";

      // Payload matching your specific request
      final Map<String, dynamic> data = {
        "contentType": "image",
        "category": selectedCategory.value,
        "music": selectedMusicId.value,
        "isPremium": false,
      };

      dio.FormData formData = dio.FormData.fromMap({
        'content': dio.MultipartFile.fromBytes(
          imageBytes,
          filename: 'story.png',
        ),
        'data': jsonEncode(data),
      });

      final res = await _api.post('/stories/create', data: formData);

      if (res.data['success'] == true) {
        CustomSnackbar.showSuccess(res.data['message']);
        return true;
      } else {
        CustomSnackbar.showError(res.data['message']);
      }
    } catch (e) {
      CustomSnackbar.showError("Failed to create story");
    } finally {
      isLoading.value = false;
      loadingStatus.value = "";
    }
    return false;
  }
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
