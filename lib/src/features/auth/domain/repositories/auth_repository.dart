import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  });
  Future<String> forgotPassword({required String email});
  Future<bool> verifyOtp({required String email, required String otp});
  Future<String> resetPassword({
    required String email,
    required String newPassword,
  });
  Future<void> resendOtp({required String email});
  Future<void> logout();
  Future<UserEntity?> getCurrentUser();
}
