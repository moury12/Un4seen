import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/services/api_service.dart';
import '../../../../core/widgets/custom_snackbar.dart';
import '../../data/models/profile_model.dart';

class ProfileController extends GetxController {
  final ApiService _api = Get.find<ApiService>();
  final _imagePicker = ImagePicker();

  final RxBool isLoading = false.obs;
  final Rx<File?> profileImage = Rx<File?>(null);

  // Observables for non-form data
  final followerCount = 0.obs;
  final followingCount = 0.obs;
  final shredPoints = 0.obs;
  final memberNumber = '#0000'.obs;
  final countryName = ''.obs;
  final Rx<ProfileModel> userProfile = ProfileModel().obs;
  final facebookUrl = '@username'.obs;
  final instagramUrl = '@username'.obs;
  final tiktokUrl = '@username'.obs;
  // Form Controllers
  // final fullNameController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final aboutMeController = TextEditingController();
  final facebookController = TextEditingController();
  final instagramController = TextEditingController();
  final tiktokController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();
  final streetController = TextEditingController();
  final cityController = TextEditingController();
  final zipController = TextEditingController();
  final stateController = TextEditingController();
  final bikeModelController = TextEditingController();
  final bikeYearController = TextEditingController();

  final selectedClothingFit = 'Mens'.obs;
  final selectedTShirtSize = 'M'.obs;
  final selectedHoodieSize = 'M'.obs;
  final selectedRideTypes = <String>[].obs;
  final selectedRidingLevels = <String>[].obs;

  final List<String> clothingFitList = ['Mens', 'Womens', 'Kids'];
  final List<String> sizeList = ['S', 'M', 'L', 'XL', 'XXL'];
  final List<String> rideTypeList = [
    'MX',
    'Enduro',
    'Ebike',
    'Atv',
    'Adventure',
    'Road',
    'Cruiser',
    'Gokart',
    'MTB',
  ];
  final List<String> ridingLevelList = [
    'Beginner',
    'Intermediate',
    'Recreational',
  ];

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    try {
      isLoading.value = true;
      final response = await _api.get('/user/my-profile');

      if (response.data['success']) {
        userProfile.value = ProfileModel.fromJson(response.data['data']);

        // Map to controllers
        firstNameController.text = userProfile.value.firstName ?? '';
        lastNameController.text = userProfile.value.lastName ?? '';
        emailController.text = userProfile.value.email ?? '';
        mobileController.text = userProfile.value.phoneNumber ?? '';
        aboutMeController.text = userProfile.value.aboutMe ?? '';
        facebookController.text = userProfile.value.facebookURL ?? '';
        instagramController.text = userProfile.value.instagramURL ?? '';
        tiktokController.text = userProfile.value.tiktokURL ?? '';

        memberNumber.value = userProfile.value.memberNumber ?? '';
        shredPoints.value = userProfile.value.shredPoints ?? 0;
        countryName.value = userProfile.value.country ?? '';
        followerCount.value = userProfile.value.followerCount ?? 0;
        followingCount.value = userProfile.value.followingCount ?? 0;
        selectedClothingFit.value = userProfile.value.clothingFit ?? 'Mens';
        selectedTShirtSize.value = userProfile.value.tShirtSize ?? 'M';
        selectedHoodieSize.value = userProfile.value.hoodieSize ?? 'M';

        if (userProfile.value.address != null) {
          streetController.text =
              userProfile.value.address!.streetAddress ?? '';
          cityController.text = userProfile.value.address!.city ?? '';
          zipController.text = userProfile.value.address!.postalCode ?? '';
          stateController.text = userProfile.value.address!.state ?? '';
        }

        if (userProfile.value.rideInfo != null) {
          bikeModelController.text =
              userProfile.value.rideInfo!.bikeModel ?? '';
          bikeYearController.text = userProfile.value.rideInfo!.year ?? '';
          selectedRideTypes.assignAll(userProfile.value.rideInfo!.rideType);
          if (userProfile.value.rideInfo!.ridingLevel != null) {
            selectedRidingLevels.assignAll([
              userProfile.value.rideInfo!.ridingLevel!,
            ]);
          }
        }
      }
    } catch (e) {
      print('❌ Fetch Error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> updateProfile({String? country, String? dob}) async {
    try {
      isLoading.value = true;
      // {
      //   "firstName": "Nahid",
      //   "lastName": "Hossain",
      //   "aboutMe": "Motocross enthusiast and professional rider. I love customizing my bike with Un4seen decals and hitting the dirt tracks of Canterbury.",
      //   "facebookURL": "https://facebook.com/nahid.mx",
      //   "instagramURL": "https://instagram.com/nahid_rider",
      //   "tiktokURL": "https://tiktok.com/@nahid_mx",
      //   "phoneNumber": "02-8312024",
      //   "address": {
      //     "streetAddress": "45 Raceway Drive",
      //     "city": "Timaru",
      //     "postalCode": "7910",
      //     "state": "Canterbury"
      //   },
      //   "clothingFit": "Mens",
      //   "tShirtSize": "L",
      //   "hoodieSize": "XL",
      //   "rideInfo": {
      //     "bikeModel": "Yamaha YZ450F",
      //     "year": "2024",
      //     "rideType": ["MX", "Enduro", "Road"],
      //     "ridingLevel": "Intermediate"
      //   },
      //   "dob": "1995-10-25"
      // }
      final Map<String, dynamic> payload = {
        "firstName": firstNameController.text,
        "lastName": lastNameController.text,
        "phoneNumber": mobileController.text,
        "aboutMe": aboutMeController.text,
        "facebookURL": facebookController.text,
        "instagramURL": instagramController.text,
        "tiktokURL": tiktokController.text,
        "clothingFit": selectedClothingFit.value,
        "tShirtSize": selectedTShirtSize.value,
        "hoodieSize": selectedHoodieSize.value,
        if (country != null) "country": country,
        if (dob != null) "dob": dob,
        "address": {
          "streetAddress": streetController.text,
          "city": cityController.text,
          "postalCode": zipController.text,
          "state": stateController.text,
        },
        "rideInfo": {
          "rideType": selectedRideTypes.toList(),
          "ridingLevel": selectedRidingLevels.isNotEmpty
              ? selectedRidingLevels.first
              : "Beginner",
          "bikeModel": bikeModelController.text,
          "year": bikeYearController.text,
        },
      };

      dio.FormData formData = dio.FormData.fromMap({
        'data': jsonEncode(payload),
      });

      if (profileImage.value != null) {
        formData.files.add(
          MapEntry(
            'image',
            await dio.MultipartFile.fromFile(profileImage.value!.path),
          ),
        );
      }

      // Changed from post to patch
      final response = await _api.patch('/user/update-profile', data: formData);

      if (response.data['success']) {
        CustomSnackbar.showSuccess(response.data['message']);
        fetchProfile(); // Refresh
        return true;
      } else {
        CustomSnackbar.showError(response.data['message']);
        return false;
      }
    } catch (e) {
      CustomSnackbar.showError("Failed to update profile");
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> pickImage() async {
    final XFile? pickedFile = await _imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      profileImage.value = File(pickedFile.path);
    }
  }

  void toggleRideType(String type) {
    if (selectedRideTypes.contains(type)) {
      selectedRideTypes.remove(type);
    } else {
      selectedRideTypes.add(type);
    }
  }

  void toggleRidingLevel(String level) {
    if (selectedRidingLevels.contains(level)) {
      selectedRidingLevels.remove(level);
    } else {
      selectedRidingLevels.add(level);
    }
  }
}
