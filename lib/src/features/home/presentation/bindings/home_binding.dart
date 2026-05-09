import 'package:get/get.dart';
import '../../data/home_data.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeRemoteDataSource>(() => HomeRemoteDataSourceImpl());
    Get.lazyPut<HomeRepositoryImpl>(() => HomeRepositoryImpl(Get.find()));
    Get.lazyPut<HomeController>(() => HomeController(Get.find<HomeRepositoryImpl>()));
  }
}
