import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:un4seen/src/features/profile/data/models/user_profile_model.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/services/api_service.dart';
import '../../../../core/widgets/custom_snackbar.dart';
import '../../data/models/profile_model.dart';

class ProfileController extends GetxController {
  final ApiService _api = Get.find<ApiService>();
  final _imagePicker = ImagePicker();

  final RxBool isLoading = false.obs;
  final Rx<File?> profileImage = Rx<File?>(null);
  final RxList<UserProfileModel> followersList = <UserProfileModel>[].obs;
  final RxList<UserProfileModel> followingList = <UserProfileModel>[].obs;
    final RxList<UserProfileModel> userfollowersList = <UserProfileModel>[].obs;
  final RxList<UserProfileModel> userfollowingList = <UserProfileModel>[].obs;
  final RxBool isListLoading = false.obs;
  final Rxn<UserProfileModel> targetMemberDetails = Rxn<UserProfileModel>();

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
    'E-Bike',
    'Saving Up',
    'Go-Kart',
    'Road',
    'Harley/Cruiser',
    'ATV',
    'Vintage',
    'Adventure/Dual sport',
    'Supermoto',
  ];
  final List<String> ridingLevelList = [
    'Beginner',
    'Intermediate',
    'Recreational',
  ];
final RxBool isPasswordLoading = false.obs;

  // ── Change Password ───────────────────────────────────
  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      isPasswordLoading.value = true;

      final response = await _api.post(
        '/auth/change-password',
        data: {
          'oldPassword': oldPassword,
          'newPassword': newPassword,
        },
      );

      final dynamic data = response.data;
      final bool isSuccess = data['success'] ?? false;
      final String message = data['message'] ?? 'Action failed';

      if (isSuccess) {
        CustomSnackbar.showSuccess(message);
        // Cleanly pop the user back to the profile screen settings menu
        AppRouter.router.pop();
      } else {
        CustomSnackbar.showError(message);
      }
    } catch (e) {
      print('Error at changePassword inside ProfileController: $e');
      CustomSnackbar.showError('Something went wrong. Please try again.');
    } finally {
      isPasswordLoading.value = false;
    }
  }
  @override
  void onInit() {
     Future.wait([
      fetchProfile(),
      fetchFollowers(),
      fetchFollowing(),
    ]);
    super.onInit();
  }

  final referralInputController = TextEditingController();

  int _followersPage = 1;
  bool _hasMoreFollowers = true;
  bool _isFollowersLoadingMore = false;

  int _followingPage = 1;
  bool _hasMoreFollowing = true;
  bool _isFollowingLoadingMore = false;

  Future<void> fetchFollowers() async {
    try {
      _followersPage = 1;
      _hasMoreFollowers = true;
      isListLoading.value = true;
      final res = await _api.get('/user/my-followers?page=$_followersPage&limit=10');
      if (res.data['success']) {
        final List result = res.data['data']['result'] ?? [];
        followersList.assignAll(result.map((e) => UserProfileModel.fromJson(e)).toList());
        final meta = res.data['data']['meta'];
        if (meta != null) {
          final int totalPage = meta['totalPage'] ?? 1;
          _hasMoreFollowers = _followersPage < totalPage;
        } else {
          _hasMoreFollowers = false;
        }
      }
    } finally {
      isListLoading.value = false;
    }
  }

  Future<void> loadMoreFollowers() async {
    if (!_hasMoreFollowers || _isFollowersLoadingMore || isListLoading.value) return;
    try {
      _isFollowersLoadingMore = true;
      final nextPage = _followersPage + 1;
      final res = await _api.get('/user/my-followers?page=$nextPage&limit=10');
      if (res.data['success']) {
        final List result = res.data['data']['result'] ?? [];
        followersList.addAll(result.map((e) => UserProfileModel.fromJson(e)).toList());
        _followersPage = nextPage;
        final meta = res.data['data']['meta'];
        if (meta != null) {
          final int totalPage = meta['totalPage'] ?? 1;
          _hasMoreFollowers = _followersPage < totalPage;
        } else {
          _hasMoreFollowers = false;
        }
      }
    } finally {
      _isFollowersLoadingMore = false;
    }
  }
// Add these to ProfileController class

  // ── Fetch Other User's Followers ──
  Future<void> fetchOtherFollowers(String userId) async {
    try {
      isListLoading.value = true;
      final res = await _api.get('/user/followers/$userId?page=1&limit=100');
      if (res.data['success']) {
        final List result = res.data['data']['result'] ?? [];
        userfollowersList.assignAll(result.map((e) => UserProfileModel.fromJson(e)).toList());
      }
    } finally {
      isListLoading.value = false;
    }
  }

  // ── Fetch Other User's Following ──
  Future<void> fetchOtherFollowing(String userId) async {
    try {
      isListLoading.value = true;
      final res = await _api.get('/user/following/$userId');
      if (res.data['success']) {
        final List result = res.data['data']['result'] ?? [];
        userfollowingList.assignAll(result.map((e) => UserProfileModel.fromJson(e)).toList());
      }
    } finally {
      isListLoading.value = false;
    }
  }

  // ── Toggle Follow (Optimistic UI) ──
  Future<void> toggleFollow(UserProfileModel user) async {
    final bool currentlyFollowing = user.isFollowing;
    final String endpoint = currentlyFollowing ? 'unfollow' : 'follow';
    
    try {
      // Hit API
      final response = await _api.patch('/user/$endpoint/${user.id}');
      if (response.data['success']) {
        CustomSnackbar.showSuccess(response.data['message']);
        // Refresh the target user details to update counts and button state
        fetchMemberDetails(user.id!);
      }
    } catch (e) {
      CustomSnackbar.showError("Failed to update follow status");
    }
  }
  Future<void> fetchFollowing() async {
    try {
      _followingPage = 1;
      _hasMoreFollowing = true;
      isListLoading.value = true;
      final res = await _api.get('/user/my-following?page=$_followingPage&limit=10');
      if (res.data['success']) {
        final List result = res.data['data']['result'] ?? [];
        followingList.assignAll(result.map((e) => UserProfileModel.fromJson(e)).toList());
        final meta = res.data['data']['meta'];
        if (meta != null) {
          final int totalPage = meta['totalPage'] ?? 1;
          _hasMoreFollowing = _followingPage < totalPage;
        } else {
          _hasMoreFollowing = false;
        }
      }
    } finally {
      isListLoading.value = false;
    }
  }

  Future<void> loadMoreFollowing() async {
    if (!_hasMoreFollowing || _isFollowingLoadingMore || isListLoading.value) return;
    try {
      _isFollowingLoadingMore = true;
      final nextPage = _followingPage + 1;
      final res = await _api.get('/user/my-following?page=$nextPage&limit=10');
      if (res.data['success']) {
        final List result = res.data['data']['result'] ?? [];
        followingList.addAll(result.map((e) => UserProfileModel.fromJson(e)).toList());
        _followingPage = nextPage;
        final meta = res.data['data']['meta'];
        if (meta != null) {
          final int totalPage = meta['totalPage'] ?? 1;
          _hasMoreFollowing = _followingPage < totalPage;
        } else {
          _hasMoreFollowing = false;
        }
      }
    } finally {
      _isFollowingLoadingMore = false;
    }
  }

  Future<void> fetchMemberDetails(String userId) async {
    try {
      isLoading.value = true;
      targetMemberDetails.value = null; // Clear previous
      final res = await _api.get('/user/$userId');
      if (res.data['success']) {
        targetMemberDetails.value = UserProfileModel.fromJson(res.data['data']);
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> applyReferral() async {
    final code = referralInputController.text.trim();
    
    if (code.isEmpty) {
      CustomSnackbar.showError("Please enter a referral code");
      return;
    }

    try {
      isLoading.value = true;
      final response = await _api.post(
        '/shred-points/apply-referral', 
        data: {"code": code},
      );

      if (response.data['success']) {
        CustomSnackbar.showSuccess(response.data['message']);
        referralInputController.clear();
        fetchProfile(); // Refresh profile to reflect changes
      } else {
        CustomSnackbar.showError(response.data['message']);
      }
    } catch (e) {
      print('❌ Apply Referral Error: $e | lib/src/features/profile/presentation/controllers/profile_controller.dart');
      CustomSnackbar.showError("Failed to apply referral code");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    referralInputController.dispose();
    // ... dispose other controllers
    super.onClose();
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
