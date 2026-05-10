import 'package:get/get.dart';
import '../controllers/bike_profiles_controller.dart';

class BikeProfilesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BikeProfilesController>(() => BikeProfilesController());
  }
}
