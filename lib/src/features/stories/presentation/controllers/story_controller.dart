import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:un4seen/src/core/core_export.dart';
import 'package:un4seen/src/core/services/api_service.dart';
import 'package:un4seen/src/core/services/socket_service.dart';
import 'package:un4seen/src/features/stories/data/models/music_model.dart';
import 'package:un4seen/src/features/stories/data/models/story_model.dart';

class StoryController extends GetxController {
  final RxBool isSoundOn = true.obs;
  final RxBool isLiked = false.obs;
    final AudioPlayer _audioPlayer = AudioPlayer();

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
// Feed States
  final RxList<StoryModel> stories = <StoryModel>[].obs;
  final RxList<StoryModel> savedStories = <StoryModel>[].obs;
  final RxBool isStoriesLoading = false.obs;
  final RxBool isSavedLoading = false.obs;
  final RxBool isViewingSaved = false.obs;

  List<StoryModel> get activeStories => isViewingSaved.value ? savedStories : stories;

  final List<String> categories = [
    'Bikes',
    'Orders',
    'Installs',
    'Winners',
    'Behind Scenes',
  ];

  // void toggleSound() {
  //   isSoundOn.value = !isSoundOn.value;
  // }
   // Story Player States
  Timer? _storyTimer;
  final RxInt currentStoryIndex = 0.obs;
  final RxDouble currentProgress = 0.0.obs;
  final int storyDurationSeconds = 5;
@override
  void onInit() {
    super.onInit();
    fetchStories();
      setupSocket();
    isSoundOn.listen((bool on) {
      if (on) {
        if (activeStories.isNotEmpty) {
          _playStory(activeStories[currentStoryIndex.value]);
        }
      } else {
        _audioPlayer.pause();
      }
    });
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
  Future<void> fetchSavedStories() async {
    try {
      isSavedLoading.value = true;
      final res = await _api.get('/stories/my-saved');
      if (res.data['success']) {
        final List data = res.data['data'];
        savedStories.assignAll(data.map((e) => StoryModel.fromJson(e)).toList());
      }
    } finally {
      isSavedLoading.value = false;
    }
  }

  Future<void> toggleHeart(StoryModel story) async {
    final originalHearted = story.isHearted;
    final originalCount = story.heartCount;

    // Optimistic UI Update
    story.isHearted = !originalHearted;
    story.heartCount = story.isHearted ? originalCount + 1 : originalCount - 1;
    stories.refresh();
    savedStories.refresh();

    try {
      await _api.patch('/stories/${story.id}/heart');
    } catch (e) {
      story.isHearted = originalHearted;
      story.heartCount = originalCount;
      stories.refresh();
    }
  }

  Future<void> toggleSave(StoryModel story) async {
    final originalSaved = story.isSaved;
    story.isSaved = !originalSaved;
    stories.refresh();

    try {
      await _api.post('/stories/${story.id}/save');
      CustomSnackbar.showSuccess(story.isSaved ? "Saved to your collection" : "Removed from saved");
    } catch (e) {
      story.isSaved = originalSaved;
      stories.refresh();
    }
  }
 void closeStoryViewer() {
    // 1. Stop the timer to prevent auto-advancing
    _storyTimer?.cancel();
    
    // 2. Stop the audio immediately
    _audioPlayer.stop();
    
    // 3. Reset progress for next time
    currentProgress.value = 0.0;
    
 
  }
  // ── Story Player Logic ─────────────────────────────────
  void startStoryTimer(int startIndex, {bool isFromSaved = false}) {
    isViewingSaved.value = isFromSaved;
    currentStoryIndex.value = startIndex;
    if (activeStories.isNotEmpty) {
      _playStory(activeStories[currentStoryIndex.value]);
    }
    _resetTimer();
  }

  void _playStory(StoryModel story) async {
    if (story.music != null && isSoundOn.value) {
      try {
        await _audioPlayer.setUrl(story.music!.audioUrl);
        _audioPlayer.setLoopMode(LoopMode.one);
        _audioPlayer.play();
      } catch (e) {
        log("Audio error: $e");
      }
    } else {
      _audioPlayer.stop();
    }
  }

  void nextStory() {
    if (currentStoryIndex.value < activeStories.length - 1) {
      currentStoryIndex.value++;
      _playStory(activeStories[currentStoryIndex.value]);
      _resetTimer();
    } else {
      _storyTimer?.cancel();
      _audioPlayer.stop();
      Get.back(); // POP at last index
    }
  }
 void _resetTimer() {
    _storyTimer?.cancel();
    currentProgress.value = 0.0;
    _storyTimer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (currentProgress.value < 1.0) {
        currentProgress.value += 0.05 / storyDurationSeconds;
      } else {
        nextStory();
      }
    });
  }
  void pauseStory() {
    _storyTimer?.cancel();
    _audioPlayer.pause();
  }
  void previousStory() {
    if (currentStoryIndex.value > 0) {
      currentStoryIndex.value--;
      _playStory(activeStories[currentStoryIndex.value]);
      _resetTimer();
    } else {
      _resetTimer(); // Restart current story if at first index
    }
  }
  void resumeStory() => _resetTimer();

  void toggleSound() => isSoundOn.value = !isSoundOn.value;
  @override
  void onClose() {
    _storyTimer?.cancel();
    _audioPlayer.dispose();
    super.onClose();
  }
}
