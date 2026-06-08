import '../../../../core/services/api_service.dart';
import '../../../../src_export.dart';
import '../../data/models/point_data_model.dart';

class PointsController extends GetxController {
  final ApiService _api = Get.find<ApiService>();

  final RxBool isLoading = false.obs;
  final Rxn<PointsDashboardModel> dashboardData = Rxn<PointsDashboardModel>();

  @override
  void onInit() {
    super.onInit();
    fetchDashboard();
  }

  Future<void> fetchDashboard() async {
    try {
      isLoading.value = true;
      final response = await _api.get('/shred-points/dashboard');
      if (response.data['success'] == true) {
        dashboardData.value = PointsDashboardModel.fromJson(
          response.data['data'],
        );
      }
    } catch (e) {
      print('❌ Dashboard Error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> claimDaily() async {
    try {
      final res = await _api.post('/shred-points/claim-daily');
      if (res.data['success']) {
        CustomSnackbar.showSuccess(res.data['message']);
        fetchDashboard();
      }
    } catch (e) {
      CustomSnackbar.showError(e.toString());
    }
  }
}
