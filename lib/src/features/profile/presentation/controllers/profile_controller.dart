import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  final _imagePicker = ImagePicker();
  
  final Rx<File?> profileImage = Rx<File?>(null);
  
  // Reactive fields for profile
  final fullName = 'Nahid Hossain'.obs;
  final aboutMe = 'I\'m a passionate and creative individual who enjoys learning new things and exploring ideas. I like expressing myself through my work and always try to improve my skills while staying curious and motivated.'.obs;
  final facebookUrl = '@nahiddd1'.obs;
  final instagramUrl = '@nahiddd1'.obs;
  final tiktokUrl = '@nahiddd1'.obs;
  final email = 'nahid@gmail.com'.obs;
  final mobileNumber = '02-8312024'.obs;
  
  // Dummy lists for dropdowns
  final List<String> clothingFitList = ['Mens', 'Womens', 'Kids'];
  final List<String> sizeList = ['S', 'M', 'L', 'XL', 'XXL'];
  final List<String> rideTypeList = ['MX', 'Enduro', 'Ebike', 'Atv', 'Adventure', 'Road', 'Cruiser', 'Gokart', 'MTB'];
  final List<String> ridingLevelList = ['Beginner', 'Intermediate', 'Recreational'];

  final selectedClothingFit = 'Mens'.obs;
  final selectedTShirtSize = 'M'.obs;
  final selectedHoodieSize = 'M'.obs;
  
  final selectedRideTypes = <String>['MX', 'Enduro', 'Ebike', 'Atv', 'Adventure', 'Road', 'Cruiser', 'Gokart', 'MTB'].obs;
  final selectedRidingLevels = <String>['Beginner', 'Intermediate', 'Recreational'].obs;

  Future<void> pickImage() async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1080, // Optimizing resolution
        maxHeight: 1080,
        imageQuality: 85, // Optimizing resolution
      );
      
      if (pickedFile != null) {
        profileImage.value = File(pickedFile.path);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick image: $e');
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
