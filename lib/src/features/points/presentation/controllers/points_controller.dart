import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:image_picker/image_picker.dart';
import '../../../../core/services/api_service.dart';
import '../../../../src_export.dart';
import '../../data/models/point_data_model.dart';

class PointsController extends GetxController {
  final ApiService _api = Get.find<ApiService>();

  final RxBool isLoading = false.obs;
  final RxBool isSubmittingProof = false.obs;
  final Rxn<PointsDashboardModel> dashboardData = Rxn<PointsDashboardModel>();
  final Rx<File?> selectedProofImage = Rx<File?>(null);
  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    fetchDashboard();
  }

  Future<void> pickProofImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedProofImage.value = File(image.path);
    }
  }

  Future<void> fetchDashboard() async {
    try {
      isLoading.value = true;
      final response = await _api.get('/shred-points/dashboard');
      if (response.data['success'] == true) {
        dashboardData.value = PointsDashboardModel.fromJson(
          response.data['data'],
        );
        if (dashboardData.value?.dailyLogin.canClaimDaily == true) {
          // claimDaily();
        }
      }
    } catch (e) {
      print(
        '❌ Dashboard Error: $e | lib/src/features/points/presentation/controllers/points_controller.dart:31',
      );
    } finally {
      isLoading.value = false;
    }
  }

  // ── Daily Login Claim ─────────────────────────────────
  Future<void> claimDaily() async {
    try {
      final res = await _api.post('/shred-points/daily-claim');
      if (res.data['success']) {
        CustomSnackbar.showSuccess(res.data['message']);
        fetchDashboard(); // Refresh UI
      } else {
        CustomSnackbar.showError(res.data['message']);
      }
    } catch (e) {
      print(
        '❌ Daily Claim Error: $e | lib/src/features/points/presentation/controllers/points_controller.dart:48',
      );
    }
  }

  // ── Profile Bonus Claim ───────────────────────────────
  Future<void> claimProfileBonus() async {
    try {
      final res = await _api.post('/shred-points/claim-profile-bonus');
      if (res.data['success']) {
        CustomSnackbar.showSuccess(res.data['message']);
        fetchDashboard();
      } else {
        CustomSnackbar.showError(res.data['message']);
      }
    } catch (e) {
      print(
        '❌ Profile Bonus Error: $e | lib/src/features/points/presentation/controllers/points_controller.dart:63',
      );
    }
  }

  // ── Claim Milestone (Individual or Community) ──────────
  Future<void> claimMilestone(String milestoneId) async {
    try {
      // Reusing isSubmittingProof or create a generic isActionLoading if preferred
      isSubmittingProof.value = true;

      final res = await _api.post(
        '/shred-points/claim-milestone',
        data: {"milestoneId": milestoneId},
      );

      if (res.data['success']) {
        CustomSnackbar.showSuccess(res.data['message']);
        await fetchDashboard(); // Refresh data to update isClaimed status
      } else {
        CustomSnackbar.showError(res.data['message']);
      }
    } catch (e) {
      print(
        '❌ Claim Milestone Error: $e | lib/src/features/points/presentation/controllers/points_controller.dart',
      );
      CustomSnackbar.showError("Failed to claim reward");
    } finally {
      isSubmittingProof.value = false;
    }
  }

  // ── Submit Social Proof ───────────────────────────────
  Future<bool> submitProof({
    required String platform,
    required String postLink,
    required File imageFile,
  }) async {
    try {
      isSubmittingProof.value = true;

      final dataPayload = jsonEncode({
        "platform": platform.toLowerCase(),
        "postLink": postLink,
      });

      dio.FormData formData = dio.FormData.fromMap({
        'data': dataPayload,
        'image': await dio.MultipartFile.fromFile(
          imageFile.path,
          filename:
              'proof_${platform}_${DateTime.now().millisecondsSinceEpoch}.jpg',
        ),
      });

      final res = await _api.post('/shred-points/submit-proof', data: formData);

      if (res.data['success']) {
        CustomSnackbar.showSuccess(res.data['message']);
        fetchDashboard();
        return true;
      } else {
        CustomSnackbar.showError(res.data['message']);
        return false;
      }
    } catch (e) {
      print(
        '❌ Submit Proof Error: $e | lib/src/features/points/presentation/controllers/points_controller.dart:97',
      );
      CustomSnackbar.showError("Failed to submit proof");
    } finally {
      isSubmittingProof.value = false;
    }
    return false;
  }
}
