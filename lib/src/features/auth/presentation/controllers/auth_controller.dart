import 'dart:async';
import 'package:get/get.dart' as getx;
import '../../../../core/widgets/custom_snackbar.dart';
import '../../../../core/services/local_storage_service.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/routes/app_routes.dart';
import '../../domain/repositories/auth_repository.dart';

enum AuthStatus { initial, loading, authenticated, unauthenticated, error }

class AuthController extends getx.GetxController {
  final AuthRepository _repository;
  AuthController(this._repository);

  final getx.Rx<AuthStatus> status = AuthStatus.initial.obs;

  // --- Timer Observables ---
  final getx.RxInt resendSeconds = 60.obs;
  final getx.RxBool canResend = false.obs;
  Timer? _timer;

  bool get isLoading => status.value == AuthStatus.loading;

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  void startResendTimer() {
    canResend.value = false;
    resendSeconds.value = 60;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendSeconds.value > 0) {
        resendSeconds.value--;
      } else {
        canResend.value = true;
        _timer?.cancel();
      }
    });
  }

  // ── Resend OTP ────────────────────────────────────────
  Future<void> resendOtp(String email) async {
    try {
      await (_repository as dynamic).resendOtp(email: email);
      CustomSnackbar.showSuccess('OTP resent successfully');
      startResendTimer();
    } catch (e) {
      CustomSnackbar.showError(e.toString());
    }
  }

  // Logic to show snackbars based on "success" key from JSON
  void _handleApiResponse(Map<String, dynamic> response,
      {required Function() onSuccess}) {
    final bool isSuccess = response['success'] ?? false;
    final String message = response['message'] ?? 'Action failed';

    if (isSuccess) {
      CustomSnackbar.showSuccess(message);
      onSuccess();
    } else {
      // Specifically showing error based on JSON "success: false"
      CustomSnackbar.showError(message);
      status.value = AuthStatus.error;
    }
  }

  // ── Login Logic ───────────────────────────────────────
  Future<void> login(String email, String password) async {
    try {
      status.value = AuthStatus.loading;
      final response = await _repository.login(email: email, password: password);

      _handleApiResponse(response, onSuccess: () async {
        final data = response['data'];
        final storage = getx.Get.find<LocalStorageService>();
        await storage.saveTokens(data['accessToken'], data['refreshToken']);
        status.value = AuthStatus.authenticated;

        // GoRouter Navigation
        AppRouter.router.go(AppRoutes.navigation);
      });
    } catch (e) {
      status.value = AuthStatus.error;
      // Note: Catch is only for network/hard crashes, UI logic is in _handleApiResponse
      print('Hard Error at lib/src/features/auth/presentation/controllers/auth_controller.dart:51');
    }
  }

  // ── Forgot Password ───────────────────────────────────
  Future<void> forgotPassword(String email) async {
    try {
      status.value = AuthStatus.loading;
      await (_repository as dynamic).forgotPassword(email: email);

      // If your repository returns the raw Map, use _handleApiResponse.
      // If it returns a string, handle success here:
      CustomSnackbar.showSuccess('OTP sent to your email');
      status.value = AuthStatus.initial;

      // GoRouter Navigation
      AppRouter.router.push(AppRoutes.otpVerification,
          extra: {'email': email, 'isForResetPass': true});
    } catch (e) {
      status.value = AuthStatus.error;
    }
  }

  // ── Verify OTP ────────────────────────────────────────
  Future<void> verifyOtp(String email, String otp, bool isForReset) async {
    try {
      status.value = AuthStatus.loading;
      final success = await _repository.verifyOtp(email: email, otp: otp);
      if (success) {
        status.value = AuthStatus.initial;
        if (isForReset) {
          AppRouter.router.push(AppRoutes.resetPassword, extra: email);
        } else {
          AppRouter.router.push(AppRoutes.setupProfile);
        }
      } else {
        CustomSnackbar.showError('Invalid OTP');
      }
    } catch (e) {
      status.value = AuthStatus.error;
    }
  }

  // ── Reset Password ────────────────────────────────────
  Future<void> resetPassword(String email, String newPassword) async {
    try {
      status.value = AuthStatus.loading;
      final msg = await _repository.resetPassword(
          email: email, newPassword: newPassword);
      CustomSnackbar.showSuccess(msg);
      status.value = AuthStatus.initial;

      // GoRouter Navigation
      AppRouter.router.go(AppRoutes.login);
    } catch (e) {
      status.value = AuthStatus.error;
    }
  }

  // ── Logout ────────────────────────────────────────────
  Future<void> logout() async {
    final storage = getx.Get.find<LocalStorageService>();
    await storage.clear();
    AppRouter.router.go(AppRoutes.login);
  }
}
