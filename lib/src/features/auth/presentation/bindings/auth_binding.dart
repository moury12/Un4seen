import 'package:get/get.dart';
import '../../../../core/services/api_service.dart';
import '../../data/datasources/auth_remote_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../controllers/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ApiService());
    Get.lazyPut<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(Get.find()),
    );
    Get.lazyPut<AuthRepositoryImpl>(() => AuthRepositoryImpl(Get.find()));
    Get.lazyPut(() => AuthController(Get.find<AuthRepositoryImpl>()));
  }
}
