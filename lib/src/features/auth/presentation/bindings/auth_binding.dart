import 'package:get/get.dart';
import '../../data/datasources/auth_remote_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../controllers/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl());
    Get.lazyPut<AuthRepositoryImpl>(() => AuthRepositoryImpl(Get.find()));
    Get.lazyPut<AuthController>(() => AuthController(Get.find<AuthRepositoryImpl>()));
  }
}
