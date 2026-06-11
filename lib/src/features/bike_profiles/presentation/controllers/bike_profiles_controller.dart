import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:image_picker/image_picker.dart';
import '../../../../src_export.dart';
import '../../../../core/services/api_service.dart';

// Helper class to manage dynamic controllers for build notes
class BuildNoteSet {
  final TextEditingController titleController = TextEditingController();
  final RxList<TextEditingController> pointControllers =
      <TextEditingController>[TextEditingController()].obs;

  void dispose() {
    titleController.dispose();
    for (var c in pointControllers) {
      c.dispose();
    }
  }
}

class BikeProfilesController extends GetxController {
  final ApiService _api = Get.find<ApiService>();
  final _imagePicker = ImagePicker();

  final RxBool isLoading = false.obs;
  final RxBool isGalleryLoading = false.obs;
  final Rxn<BikeModel> activeBike = Rxn<BikeModel>();
  final Rxn<BikeModel> singleBikeDetails = Rxn<BikeModel>();
  final RxList<BikeModel> retiredBikes = <BikeModel>[].obs;
  final RxList<String> bikeGallery = <String>[].obs;
  final Rx<File?> profileImage = Rx<File?>(null);
  final RxList<BuildNoteSet> buildNoteSets = <BuildNoteSet>[BuildNoteSet()].obs;

  void addNewBuildNote() {
    buildNoteSets.add(BuildNoteSet());
  }

  void addPointToNote(int noteIndex) {
    buildNoteSets[noteIndex].pointControllers.add(TextEditingController());
  }

  void removeBuildNote(int index) {
    if (buildNoteSets.length > 1) {
      buildNoteSets[index].dispose();
      buildNoteSets.removeAt(index);
    }
  }

  @override
  void onClose() {
    for (var set in buildNoteSets) {
      set.dispose();
    }
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
    fetchBikeProfile();
  }

  Future<void> fetchBikeProfile() async {
    try {
      isLoading.value = true;
      final res = await _api.get('/bikes/profile');
      if (res.data['success']) {
        final data = BikeProfileResponse.fromJson(res.data['data']);
        activeBike.value = data.activeBike;
        retiredBikes.assignAll(data.retiredBikes);
      }
    } catch (e) {
      print('❌ Fetch Bike Profile Error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchSingleBike(String id) async {
    try {
      isLoading.value = true;
      final res = await _api.get('/bikes/$id');
      if (res.data['success']) {
        singleBikeDetails.value = BikeModel.fromJson(res.data['data']);
      }
    } catch (e) {
      print('❌ Fetch Single Bike Error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchGallery(String id) async {
    try {
      isGalleryLoading.value = true;
      final res = await _api.get('/bikes/$id/gallery');
      if (res.data['success']) {
        bikeGallery.assignAll(List<String>.from(res.data['data']));
      }
    } catch (e) {
      print('❌ Fetch Gallery Error: $e');
    } finally {
      isGalleryLoading.value = false;
    }
  }

  Future<void> addImagesToGallery(String bikeId) async {
    final XFile? image = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1080,
      maxHeight: 1080,
      imageQuality: 85,
    );
    if (image == null) return;

    try {
      isGalleryLoading.value = true;
      final formData = dio.FormData.fromMap({
        'images': await dio.MultipartFile.fromFile(image.path),
      });
      await _api.patch('/bikes/$bikeId/add-to-gallery', data: formData);
      fetchGallery(bikeId);
    } catch (e) {
      print('❌ Add Gallery Images Error: $e');
      CustomSnackbar.showError("Failed to upload image");
    } finally {
      isGalleryLoading.value = false;
    }
  }

  // ── Add Bike Logic ───────────────────────────────────────
  Future<bool> addBike({
    required String year,
    required String make,
    required String model,
    required String type,
    required String color,
  }) async {
    if (profileImage.value == null) {
      CustomSnackbar.showError("Please upload a bike image");
      return false;
    }

    try {
      isLoading.value = true;

      // Map dynamic controllers to the required JSON structure
      List<Map<String, dynamic>> formattedNotes = buildNoteSets.map((set) {
        return {
          "title": set.titleController.text.trim(),
          "points": set.pointControllers.map((c) => c.text.trim()).toList(),
        };
      }).toList();

      final formData = dio.FormData.fromMap({
        'image': await dio.MultipartFile.fromFile(profileImage.value!.path),
        'data': jsonEncode({
          "year": year,
          "make": make,
          "model": model,
          "bikeType": type,
          "color": color,
          "buildNotes": formattedNotes,
        }),
      });

      final res = await _api.post('/bikes/add-bike', data: formData);
      if (res.data['success']) {
        CustomSnackbar.showSuccess(res.data['message']);
        profileImage.value = null;

        fetchBikeProfile();
        return true;
      }
    } catch (e) {
      log(e.toString());
      CustomSnackbar.showError("Failed to add bike");
    } finally {
      isLoading.value = false;
    }
    return false;
  }

  Future<void> removeImageFromGallery(String bikeId, String imageUrl) async {
    try {
      isGalleryLoading.value = true;
      final res = await _api.patch(
        '/bikes/$bikeId/remove-images',
        data: {
          "imageUrls": [imageUrl],
        },
      );

      if (res.data['success'] == true) {
        CustomSnackbar.showSuccess(res.data['message'] ?? "Image removed");
        fetchGallery(bikeId);
      } else {
        CustomSnackbar.showError(res.data['message']);
      }
    } catch (e) {
      print(
        '❌ Remove Image Error: $e | lib/src/features/bike_profiles/presentation/controllers/bike_profiles_controller.dart',
      );
      CustomSnackbar.showError("Failed to remove image");
    } finally {
      isGalleryLoading.value = false;
    }
  }

  Future<void> pickImage() async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1080,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        profileImage.value = File(pickedFile.path);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick image: $e');
    }
  }
}
