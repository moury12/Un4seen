import 'package:get/get.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';

enum AuthStatus { initial, loading, authenticated, unauthenticated, error }

class AuthController extends GetxController {
  final AuthRepository _repository;

  AuthController(this._repository);

  // ── Observables ───────────────────────────────────────
  final Rx<AuthStatus> status = AuthStatus.initial.obs;
  final Rxn<UserEntity> user  = Rxn<UserEntity>();
  final RxString errorMessage = ''.obs;

  // Form fields (kept here so they survive sheet rebuilds)
  final RxString email    = ''.obs;
  final RxString password = ''.obs;

  bool get isLoading        => status.value == AuthStatus.loading;
  bool get isAuthenticated  => status.value == AuthStatus.authenticated;

  // ── Actions ───────────────────────────────────────────
  Future<void> login() async {
    if (email.isEmpty || password.isEmpty) {
      errorMessage.value = 'Please fill all fields';
      return;
    }
    try {
      status.value = AuthStatus.loading;
      final result = await _repository.login(
        email: email.value.trim(),
        password: password.value.trim(),
      );
      user.value   = result;
      status.value = AuthStatus.authenticated;
      Get.offAllNamed('/home');
    } catch (e) {
      errorMessage.value = e.toString();
      status.value = AuthStatus.error;
    }
  }

  Future<void> logout() async {
    await _repository.logout();
    user.value   = null;
    status.value = AuthStatus.unauthenticated;
    Get.offAllNamed('/login');
  }
}
