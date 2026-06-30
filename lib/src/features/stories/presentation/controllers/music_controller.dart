import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import '../../../../core/services/api_service.dart';
import '../../../../core/widgets/custom_snackbar.dart';
import '../../data/models/music_model.dart';

class MusicController extends GetxController {
  final ApiService _api = Get.find<ApiService>();
  final AudioPlayer _audioPlayer = AudioPlayer();

  final RxList<MusicModel> musicList = <MusicModel>[].obs;
  final RxList<String> categories = <String>[].obs;
  final RxString selectedCategory = 'All'.obs;
  final RxString searchQuery = ''.obs;
  final RxBool isLoading = false.obs;

  final RxString currentPlayingId = ''.obs;
  final RxBool isPlaying = false.obs;

  @override
  void onInit() {
    super.onInit();
    Future.wait([fetchCategories(), fetchMusic()]);

    // Listen to player state for UI updates
    _audioPlayer.playerStateStream.listen((state) {
      isPlaying.value = state.playing;
    });
  }

  Future<void> fetchCategories() async {
    try {
      final res = await _api.get('/music/categories');
      if (res.data['success']) {
        categories.assignAll(['All', ...List<String>.from(res.data['data'])]);
      }
    } catch (e) {
      debugPrint("Error categories: $e");
    }
  }

  Future<void> fetchMusic() async {
    try {
      isLoading.value = true;
      String path = '/music?search=${searchQuery.value}';
      if (selectedCategory.value != 'All') {
        path += '&category=${selectedCategory.value}';
      }

      final res = await _api.get(path);
      if (res.data['success']) {
        final List data = res.data['data']['result'];
        musicList.assignAll(data.map((e) => MusicModel.fromJson(e)).toList());
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> playToggle(MusicModel music) async {
    if (currentPlayingId.value == music.id && isPlaying.value) {
      await _audioPlayer.pause();
    } else {
      currentPlayingId.value = music.id;
      try {
        await _audioPlayer.setUrl(music.audioUrl);
        _audioPlayer.play();
      } catch (e) {
        CustomSnackbar.showError("Could not play audio");
      }
    }
  }

  Future<void> toggleFavorite(MusicModel music) async {
    final original = music.isFavorite;
    music.isFavorite = !original;
    musicList.refresh();

    try {
      await _api.patch('/music/favorite/${music.id}');
    } catch (e) {
      music.isFavorite = original;
      musicList.refresh();
    }
  }

  Future<void> stop() async {
    try {
      await _audioPlayer.stop();
      currentPlayingId.value = '';
    } catch (e) {
      debugPrint("Error stopping music: $e");
    }
  }

  Future<void> pause() async {
    try {
      await _audioPlayer.pause();
    } catch (e) {
      debugPrint("Error pausing music: $e");
    }
  }

  @override
  void onClose() {
    _audioPlayer.dispose();
    super.onClose();
  }
}
