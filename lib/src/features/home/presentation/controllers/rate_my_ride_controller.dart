import 'dart:convert';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import '../../../../core/services/api_service.dart';
import '../../../../core/widgets/custom_snackbar.dart';
import '../../data/models/ride_model.dart';
import 'home_controller.dart';

class RateMyRideController extends GetxController {
  final ApiService _api = Get.find<ApiService>();

  final RxList<RideModel> rides = <RideModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isMoreLoading = false.obs;
  final RxBool isSubmitting = false.obs;

  final RxList<RideModel> myRides = <RideModel>[].obs;
  final RxBool isMyRidesLoading = false.obs;

  int _currentPage = 1;
  int _totalPage = 1;

  @override
  void onInit() {
    super.onInit();
    fetchRides();
  }

  Future<void> fetchRides({bool isRefresh = false}) async {
    if (isRefresh) {
      _currentPage = 1;
      rides.clear();
    }

    try {
      if (_currentPage == 1)
        isLoading.value = true;
      else
        isMoreLoading.value = true;

      final response = await _api.get('/rides?page=$_currentPage&limit=10');

      if (response.data['success']) {
        final feed = RideFeedModel.fromJson(response.data['data']);
        rides.addAll(feed.result);
        _totalPage = feed.meta.totalPage;
      }
    } finally {
      isLoading.value = false;
      isMoreLoading.value = false;
    }
  }

  void loadMore() {
    if (_currentPage < _totalPage && !isMoreLoading.value) {
      _currentPage++;
      fetchRides();
    }
  }

  Future<void> toggleHeart(int index) async {
    final ride = rides[index];
    final originalState = ride.isHearted;
    final originalCount = ride.heartCount;

    // Instant Optimistic UI Update
    ride.isHearted = !ride.isHearted;
    ride.heartCount = ride.isHearted
        ? ride.heartCount + 1
        : ride.heartCount - 1;
    rides[index] = ride;
    rides.refresh();

    try {
      final res = await _api.patch('/rides/${ride.id}/heart');
      if (!res.data['success']) throw Exception();
    } catch (e) {
      // Rollback on failure
      ride.isHearted = originalState;
      ride.heartCount = originalCount;
      rides[index] = ride;
      rides.refresh();
    }
  }

  Future<void> submitVote(int index, int rating) async {
    final ride = rides[index];
    final originalRating = ride.myRating;
    final originalIsVoted = ride.isVoted;

    // Instant Optimistic UI Update
    ride.myRating = rating;
    ride.isVoted = true;
    rides[index] = ride;
    rides.refresh();

    try {
      final res = await _api.patch(
        '/rides/${ride.id}/vote',
        data: {'rating': rating},
      );
      if (!res.data['success']) throw Exception();

      // Update average rating if returned by backend (optional, but good if we have it)
      if (res.data['data'] != null &&
          res.data['data']['averageRating'] != null) {
        ride.averageRating = res.data['data']['averageRating'].toDouble();
        rides[index] = ride;
        rides.refresh();
      }
    } catch (e) {
      // Rollback on failure
      ride.myRating = originalRating;
      ride.isVoted = originalIsVoted;
      rides[index] = ride;
      rides.refresh();
      CustomSnackbar.showError("Failed to submit rating");
    }
  }

  // Inside RateMyRideController class
  Future<bool> uploadRide(String model, String desc, String type) async {
    // 1. Validation
    if (model.isEmpty || desc.isEmpty) {
      CustomSnackbar.showError("Please fill in all fields");
      return false;
    }

    final homeCtrl = Get.find<HomeController>();
    if (homeCtrl.selectedRideImage.value == null) {
      CustomSnackbar.showError("Please select a bike photo");
      return false;
    }

    try {
      isSubmitting.value = true;

      // 2. Prepare Form Data
      // Your API expects 'data' key to contain a JSON string
      final payload = jsonEncode({
        "bikeModel": model,
        "description": desc,
        "rideType": "no data",
      });

      dio.FormData formData = dio.FormData.fromMap({
        'data': payload,
        'image': await dio.MultipartFile.fromFile(
          homeCtrl.selectedRideImage.value!.path,
          filename: 'ride_image.jpg',
        ),
      });

      // 3. Hit API
      final res = await _api.post('/rides/upload', data: formData);

      // 4. Handle Response
      if (res.data['success'] == true) {
        CustomSnackbar.showSuccess(res.data['message'] ?? "Ride uploaded!");

        // Cleanup
        homeCtrl.selectedRideImage.value = null;
        // Close Dialog

        // Refresh the list to show new ride
        fetchRides(isRefresh: true);
        return true;
      } else {
        CustomSnackbar.showError(res.data['message'] ?? "Upload failed");
        return false;
      }
    } catch (e) {
      print(
        "❌ Upload Error: $e | File: lib/src/features/home/presentation/controllers/rate_my_ride_controller.dart",
      );
      CustomSnackbar.showError("Something went wrong during upload");
    } finally {
      isSubmitting.value = false;
    }
    return false;
  }

  Future<void> fetchMyRides() async {
    try {
      isMyRidesLoading.value = true;
      final response = await _api.get('/rides/my-rides');
      if (response.data['success']) {
        final feed = RideFeedModel.fromJson(response.data['data']);
        myRides.value = feed.result;
      }
    } catch (e) {
      CustomSnackbar.showError("Failed to load my rides");
    } finally {
      isMyRidesLoading.value = false;
    }
  }

  Future<void> deleteMyRide(String rideId) async {
    try {
      final res = await _api.delete('/rides/$rideId');
      if (res.data['success']) {
        myRides.removeWhere((ride) => ride.id == rideId);
        rides.removeWhere((ride) => ride.id == rideId);
        CustomSnackbar.showSuccess("Ride deleted successfully");
      }
    } catch (e) {
      CustomSnackbar.showError("Failed to delete ride");
    }
  }
}
