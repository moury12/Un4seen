// lib/src/features/un4seen_world/presentation/controllers/un4seen_world_controller.dart

import 'package:get/get.dart';
import '../../../../core/services/api_service.dart'; // Adjust path based on your exact tree
import '../../../../core/widgets/custom_snackbar.dart';
import '../../data/models/brand_model.dart';

class Un4seenWorldController extends GetxController {
  final ApiService _apiService = Get.find<ApiService>();

  final RxList<BrandModel> brands = <BrandModel>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchBrands();
  }

  Future<void> fetchBrands() async {
    try {
      isLoading.value = true;
      // Replaces hardcoded values with your new relative endpoint
      final response = await _apiService.get('/un4seen-world'); 
      
      if (response.data != null && response.data['success'] == true) {
        final List dynamicList = response.data['data']['result'] ?? [];
        brands.assignAll(dynamicList.map((e) => BrandModel.fromJson(e)).toList());
      } else {
        CustomSnackbar.showError(response.data['message'] ?? 'Failed to load brands');
      }
    } catch (e) {
      print('Error fetching brands: $e');
      CustomSnackbar.showError('Something went wrong while fetching partner brands');
    } finally {
      isLoading.value = false;
    }
  }
}