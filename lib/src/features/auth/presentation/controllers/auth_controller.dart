import 'dart:async';
import 'package:get/get.dart' as getx;
import 'package:get/state_manager.dart';
import 'package:un4seen/src/features/profile/data/models/profile_model.dart';
import '../../../../core/widgets/custom_snackbar.dart';
import '../../../../core/services/local_storage_service.dart';
import '../../../../core/services/socket_service.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../src_export.dart';
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
  Rx<ProfileModel> userProfile = ProfileModel().obs;

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
  void _handleApiResponse(
    Map<String, dynamic> response, {
    required Function() onSuccess,
  }) {
    final bool isSuccess = response['success'] ?? false;
    final String message = response['message'] ?? 'Action failed';

    if (isSuccess) {
      CustomSnackbar.showSuccess(message);
      onSuccess();
    } else {
      CustomSnackbar.showError(message);
      status.value = AuthStatus.error;
    }
  }

  // ── Login Logic ───────────────────────────────────────
  Future<void> login(String email, String password) async {
    try {
      status.value = AuthStatus.loading;
      final response = await _repository.login(
        email: email,
        password: password,
      );

      _handleApiResponse(
        response,
        onSuccess: () async {
          final data = response['data'];
          final storage = getx.Get.find<LocalStorageService>();
          await storage.saveTokens(data['accessToken'], data['refreshToken']);
          if (getx.Get.isRegistered<SocketService>()) {
            getx.Get.find<SocketService>().initSocket();
          }
          status.value = AuthStatus.authenticated;
          userProfile.value = ProfileModel.fromJson(data['user']);
  _reinitializeAllBindings();
          if (userProfile.value.isProfileComplete == false ||
              userProfile.value.isProfileComplete == null) {
            AppRouter.router.go(AppRoutes.setupProfile);
          } else {
            AppRouter.router.go(AppRoutes.navigation);
          }
        },
      );
    } catch (e) {
      status.value = AuthStatus.error;
      print('Hard Error at login: $e');
    }
  }
// Helper method to refresh everything
void _reinitializeAllBindings() {
  HomeBinding().dependencies();
  NavigationBinding().dependencies();
  CompetitionsBinding().dependencies();
  GiveawayBinding().dependencies();
  PointsBinding().dependencies();
  StoriesBinding().dependencies();
  ProfileBinding().dependencies();
  OrdersBinding().dependencies();
  SubscriptionBinding().dependencies();
  BikeProfilesBinding().dependencies();
}
  // ── Forgot Password ───────────────────────────────────
  Future<void> forgotPassword(String email) async {
    try {
      status.value = AuthStatus.loading;
      await (_repository as dynamic).forgotPassword(email: email);

      CustomSnackbar.showSuccess('OTP sent to your email');
      status.value = AuthStatus.initial;

      AppRouter.router.push(
        AppRoutes.otpVerification,
        extra: {'email': email, 'isForResetPass': true},
      );
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
        email: email,
        newPassword: newPassword,
      );
      CustomSnackbar.showSuccess(msg);
      status.value = AuthStatus.initial;

      AppRouter.router.go(AppRoutes.login);
    } catch (e) {
      status.value = AuthStatus.error;
    }
  }

  // ── Smart Logout ──────────────────────────────────────
 // lib/src/features/auth/presentation/controllers/auth_controller.dart

Future<void> logout() async {
  try {
    // 1. Safely disconnect socket
    if (getx.Get.isRegistered<SocketService>()) {
      getx.Get.find<SocketService>().disconnectSocket();
    }

    // 2. Clear local storage (Tokens, etc.)
    final storage = getx.Get.find<LocalStorageService>();
    await storage.clear();

    // 3. THE MAGIC: Wipe all GetX controllers, bindings, and instances from memory
    // This ensures no "ProfileController" or "HomeController" from the old user stays alive.
    getx.Get.reset();

    // 4. Re-initialize essential global services required for the app to function
    // We need Storage and AuthBinding so the Login page can work again.
    final newStorage = await LocalStorageService().init();
    getx.Get.put(newStorage, permanent: true);
    
    // Put SocketService back (but don't init until login)
    getx.Get.put(SocketService(), permanent: true);

    // Re-run AuthBinding so the Login/Splash page can find the AuthController
    AuthBinding().dependencies();

    // 5. Force navigate to Login
    // Since we reset everything, this is like a fresh boot
await Future.delayed(const Duration(milliseconds: 100));
AppRouter.router.go(AppRoutes.login);  } catch (e) {
    print("Error during hard logout: $e");
    // Fallback navigation
    AppRouter.router.go(AppRoutes.login);
  }
}
  }