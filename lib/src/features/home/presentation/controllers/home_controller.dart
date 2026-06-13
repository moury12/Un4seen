import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../data/home_data.dart';

class HomeController extends GetxController {
  final HomeRepository _repository;

  HomeController(this._repository);

  // ── State ─────────────────────────────────────────────
  final Rxn<HomeFeedModel> homeFeedData = Rxn<HomeFeedModel>();
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  final Rx<File?> selectedRideImage = Rx<File?>(null);
  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    fetchHomeFeed();
  }

  // ── Actions ───────────────────────────────────────────
  Future<void> fetchHomeFeed() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      homeFeedData.value = await _repository.getHomeFeed();
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refresh() => fetchHomeFeed();

  Future<void> pickRideImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedRideImage.value = File(image.path);
    }
  }

  Future<void> pickRideImageFromCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      selectedRideImage.value = File(image.path);
    }
  }
}
