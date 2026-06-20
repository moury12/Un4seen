// lib/src/features/profile/presentation/controllers/app_content_controller.dart

import 'package:get/get.dart';
import 'package:un4seen/src/features/profile/data/models/app_content_model.dart';
import '../../../../core/services/api_service.dart';

class AppContentController extends GetxController {
  final ApiService _api = Get.find<ApiService>();

  final Rxn<AppContentModel> privacyPolicy = Rxn<AppContentModel>();
  final Rxn<AppContentModel> termsCondition = Rxn<AppContentModel>();
  final Rxn<AppContentModel> aboutUs = Rxn<AppContentModel>();

  final RxBool isPrivacyLoading = false.obs;
  final RxBool isTermsLoading = false.obs;
  final RxBool isAboutLoading = false.obs;

  Future<void> fetchPrivacyPolicy() => _loadContent('/privacy/retrive', 'privacyPolicy', privacyPolicy, isPrivacyLoading);
  Future<void> fetchTermsCondition() => _loadContent('/terms/retrive', 'termsCondition', termsCondition, isTermsLoading);
  Future<void> fetchAboutUs() => _loadContent('/about/retrive', 'aboutUs', aboutUs, isAboutLoading);

  Future<void> _loadContent(String path, String key, Rxn<AppContentModel> target, RxBool loader) async {
    try {
      loader.value = true;
      final res = await _api.get(path);
      if (res.data['success'] == true && res.data['data'] != null) {
        target.value = AppContentModel.fromJson(res.data['data'], key);
      }
    } catch (e) {
      print('❌ Error loading target $path: $e');
    } finally {
      loader.value = false;
    }
  }
}