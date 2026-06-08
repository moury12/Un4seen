import 'dart:convert';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import '../../../../core/services/api_service.dart';
import '../../../../core/widgets/custom_snackbar.dart';
import '../../data/models/competition_model.dart';
import '../../data/models/competition_entry_model.dart';

class CompetitionsController extends GetxController {
  final ApiService _api = Get.find<ApiService>();

  final RxBool isCompLoading = false.obs;
  final RxBool isGalleryLoading = false.obs;
  final RxBool isSubmitting = false.obs;

  final RxList<CompetitionModel> activeComps = <CompetitionModel>[].obs;
  final RxList<CompetitionModel> upcomingComps = <CompetitionModel>[].obs;
  final RxList<CompetitionModel> endedComps = <CompetitionModel>[].obs;
  final RxList<CompetitionEntryModel> entries = <CompetitionEntryModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllCompetitions();
  }

  Future<void> fetchAllCompetitions() async {
    isCompLoading.value = true;
    await Future.wait([
      _fetchByStatus('active', activeComps),
      _fetchByStatus('upcoming', upcomingComps),
      _fetchByStatus('ended', endedComps),
    ]);
    isCompLoading.value = false;
  }

  Future<void> _fetchByStatus(String status, RxList<CompetitionModel> list) async {
    try {
      final res = await _api.get('/competitions/all?status=$status');
      if (res.data['success'] == true) {
        final results = res.data['data']['result'] as List;
        list.assignAll(results.map((e) => CompetitionModel.fromJson(e)).toList());
      }
    } catch (e) {
      print('❌ Error fetching $status competitions: $e');
    }
  }

  Future<void> fetchGallery(String compId) async {
    try {
      isGalleryLoading.value = true;
      entries.clear();
      final res = await _api.get('/competitions/gallery/$compId');
      if (res.data['success'] == true) {
        final data = res.data['data'] as List;
        entries.assignAll(data.map((e) => CompetitionEntryModel.fromJson(e)).toList());
      }
    } catch (e) {
      print('❌ Error fetching gallery: $e');
    } finally {
      isGalleryLoading.value = false;
    }
  }

  Future<void> toggleHeart(int index) async {
    final entry = entries[index];
    final originalState = entry.isHearted;
    final originalCount = entry.heartCount;

    // Instant optimistic UI update
    entry.isHearted = !entry.isHearted;
    entry.heartCount = entry.isHearted ? entry.heartCount + 1 : entry.heartCount - 1;
    entries[index] = entry;
    entries.refresh();

    try {
      await _api.patch('/competitions/entry/${entry.id}/heart');
    } catch (e) {
      // Rollback on failure
      entry.isHearted = originalState;
      entry.heartCount = originalCount;
      entries[index] = entry;
      entries.refresh();
    }
  }

  Future<bool> submitDesign(String compId, String name, String imagePath) async {
    try {
      isSubmitting.value = true;
      final formData = dio.FormData.fromMap({
        'data': jsonEncode({"designName": name, "competition": compId}),
        'image': await dio.MultipartFile.fromFile(imagePath),
      });

      final res = await _api.post('/competitions/submit-entry', data: formData);
      if (res.data['success'] == true) {
        CustomSnackbar.showSuccess(res.data['message'] ?? 'Design submitted!');
        return true;
      } else {
        CustomSnackbar.showError(res.data['message'] ?? 'Submission failed.');
      }
    } catch (e) {
      print('❌ Error submitting design: $e');
      CustomSnackbar.showError('Something went wrong. Please try again.');
    } finally {
      isSubmitting.value = false;
    }
    return false;
  }
}
