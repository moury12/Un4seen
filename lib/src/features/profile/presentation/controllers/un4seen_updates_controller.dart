import 'dart:async';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:un4seen/src/core/services/api_service.dart';
import 'package:un4seen/src/core/services/local_storage_service.dart';
import 'package:un4seen/src/core/widgets/custom_snackbar.dart';
import 'package:un4seen/src/features/profile/data/models/announcement_model.dart';

class Un4seenUpdatesController extends GetxController {
  final ApiService _api = Get.find<ApiService>();
  final LocalStorageService _storage = Get.find<LocalStorageService>();
  final AudioPlayer _audioPlayer = AudioPlayer();

  final RxList<AnnouncementModel> announcements = <AnnouncementModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isRefreshing = false.obs;
  final RxBool hasError = false.obs;
  final RxString errorMessage = ''.obs;

  final RxBool hasUnreadUpdates = false.obs;

  // Story Viewer state
  Timer? _storyTimer;
  final RxInt currentAnnouncementIndex = 0.obs;
  final RxDouble currentProgress = 0.0.obs;
  final RxBool isSoundOn = true.obs;
  final int storyDurationSeconds = 15;

  @override
  void onInit() {
    super.onInit();
    fetchAnnouncements();

    isSoundOn.listen((bool on) {
      if (announcements.isNotEmpty) {
        final current = announcements[currentAnnouncementIndex.value];
        if (on && current.music != null && current.music!.audioUrl.isNotEmpty) {
          _playMusic(current.music!.audioUrl);
        } else {
          _audioPlayer.pause();
        }
      }
    });
  }

  Future<void> fetchAnnouncements({bool isRefresh = false}) async {
    try {
      if (isRefresh) {
        isRefreshing.value = true;
      } else {
        isLoading.value = true;
      }
      hasError.value = false;
      errorMessage.value = '';

      final response = await _api.get('/announcements');

      if (response.data != null && response.data['success'] == true) {
        final List data = response.data['data'] ?? [];
        final parsedList = data
            .map((e) => AnnouncementModel.fromJson(e))
            .toList();

        announcements.assignAll(parsedList);

        // Check unread badge state
        _checkUnreadBadge();

        if (announcements.isNotEmpty) {
          startStoryTimer(0);
        }
      } else {
        if (!isRefresh && announcements.isEmpty) {
          hasError.value = true;
          errorMessage.value =
              response.data?['message'] ?? 'Failed to load announcements';
        }
      }
    } catch (e) {
      log("Error fetching announcements: $e");
      if (!isRefresh && announcements.isEmpty) {
        hasError.value = true;
        errorMessage.value = 'Failed to connect. Please try again.';
      }
    } finally {
      isLoading.value = false;
      isRefreshing.value = false;
    }
  }

  void _checkUnreadBadge() {
    if (announcements.isNotEmpty) {
      final String latestId = announcements.first.id;
      final String? savedId = _storage.lastViewedAnnouncementId;
      if (savedId == null || savedId != latestId) {
        hasUnreadUpdates.value = true;
      } else {
        hasUnreadUpdates.value = false;
      }
    } else {
      hasUnreadUpdates.value = false;
    }
  }

  void markAsRead() {
    if (announcements.isNotEmpty) {
      final String latestId = announcements.first.id;
      _storage.saveLastViewedAnnouncementId(latestId);
      hasUnreadUpdates.value = false;
    }
  }

  // ── Story Navigation & Timer Logic ──────────────────────
  void startStoryTimer(int startIndex) {
    if (announcements.isEmpty) return;
    currentAnnouncementIndex.value = startIndex;
    _playCurrentAnnouncement(announcements[currentAnnouncementIndex.value]);
    _resetTimer();
  }

  void _playCurrentAnnouncement(AnnouncementModel announcement) async {
    if (announcement.music != null &&
        announcement.music!.audioUrl.isNotEmpty &&
        isSoundOn.value) {
      log("🎵 Playing background music: ${announcement.music!.title}");
      _playMusic(announcement.music!.audioUrl);
    } else {
      log(
        "🔇 No music for announcement or sound is disabled. Stopping audio player.",
      );
      _audioPlayer.stop();
    }
  }

  Future<void> _playMusic(String url) async {
    try {
      await _audioPlayer.setUrl(url);
      _audioPlayer.setLoopMode(LoopMode.one);
      _audioPlayer.play();
    } catch (e) {
      log("❌ Audio play error: $e");
    }
  }

  void nextAnnouncement() {
    if (currentAnnouncementIndex.value < announcements.length - 1) {
      currentAnnouncementIndex.value++;
      _playCurrentAnnouncement(announcements[currentAnnouncementIndex.value]);
      _resetTimer();
    } else {
      _storyTimer?.cancel();
      _audioPlayer.stop();
      Get.back();
    }
  }

  void previousAnnouncement() {
    if (currentAnnouncementIndex.value > 0) {
      currentAnnouncementIndex.value--;
      _playCurrentAnnouncement(announcements[currentAnnouncementIndex.value]);
      _resetTimer();
    } else {
      _resetTimer();
    }
  }

  void _resetTimer() {
    _storyTimer?.cancel();
    currentProgress.value = 0.0;
    _storyTimer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (currentProgress.value < 1.0) {
        currentProgress.value += 0.05 / storyDurationSeconds;
      } else {
        nextAnnouncement();
      }
    });
  }

  void pauseStory() {
    _storyTimer?.cancel();
    _audioPlayer.pause();
  }

  void resumeStory() {
    _resetTimer();
    if (announcements.isNotEmpty) {
      final announcement = announcements[currentAnnouncementIndex.value];
      if (announcement.music != null &&
          announcement.music!.audioUrl.isNotEmpty &&
          isSoundOn.value) {
        _audioPlayer.play();
      }
    }
  }

  void toggleSound() {
    isSoundOn.value = !isSoundOn.value;
    if (announcements.isNotEmpty) {
      _playCurrentAnnouncement(announcements[currentAnnouncementIndex.value]);
    }
  }

  void closeViewer() {
    _storyTimer?.cancel();
    _audioPlayer.stop();
    currentProgress.value = 0.0;
  }

  // ── Heart & Save Actions ───────────────────────────────
  Future<void> toggleHeart(AnnouncementModel announcement) async {
    final bool previousState = announcement.isHearted;
    final int previousCount = announcement.heartCount;

    // Optimistic UI update
    announcement.isHearted = !previousState;
    announcement.heartCount = announcement.isHearted
        ? previousCount + 1
        : previousCount - 1;
    announcements.refresh();

    try {
      final response = await _api.patch(
        '/announcements/${announcement.id}/heart',
      );
      if (response.data != null && response.data['success'] == true) {
        final data = response.data['data'];
        if (data != null && data['heartCount'] != null) {
          announcement.heartCount = data['heartCount'] is int
              ? data['heartCount']
              : int.tryParse(data['heartCount'].toString()) ??
                    announcement.heartCount;
        }
      } else {
        // Rollback
        announcement.isHearted = previousState;
        announcement.heartCount = previousCount;
        announcements.refresh();
      }
    } catch (e) {
      log("Error toggling heart: $e");
      announcement.isHearted = previousState;
      announcement.heartCount = previousCount;
      announcements.refresh();
    }
  }

  Future<void> toggleSave(AnnouncementModel announcement) async {
    final bool previousState = announcement.isSaved;

    // Optimistic UI update
    announcement.isSaved = !previousState;
    announcements.refresh();

    try {
      final response = await _api.post(
        '/announcements/${announcement.id}/save',
      );
      if (response.data != null && response.data['success'] == true) {
        final message =
            response.data['message'] ??
            (announcement.isSaved
                ? 'Announcement saved successfully'
                : 'Announcement removed from saved');
        CustomSnackbar.showSuccess(message);
      } else {
        // Rollback
        announcement.isSaved = previousState;
        announcements.refresh();
      }
    } catch (e) {
      log("Error toggling save: $e");
      announcement.isSaved = previousState;
      announcements.refresh();
      CustomSnackbar.showError('Failed to update save status');
    }
  }

  @override
  void onClose() {
    _storyTimer?.cancel();
    _audioPlayer.dispose();
    super.onClose();
  }
}
