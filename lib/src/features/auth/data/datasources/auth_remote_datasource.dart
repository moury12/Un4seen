import '../../../../core/services/api_service.dart';

abstract class AuthRemoteDataSource {
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
    required String token,
  });
  Future<String> forgotPassword({required String email});
  Future<bool> verifyOtp({required String email, required String otp});
  Future<String> resetPassword({
    required String email,
    required String newPassword,
  });
  Future<void> resendOtp({required String email});
  Future<void> logout();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiService _api;
  AuthRemoteDataSourceImpl(this._api);

  @override
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
    required String token,
  }) async {
    final response = await _api.post(
      '/auth/login',
      data: {'email': email, 'password': password, 'fcmToken': token},
    );
    return response.data;
  }

  @override
  Future<String> forgotPassword({required String email}) async {
    final response = await _api.post(
      '/auth/forgot-password',
      data: {'email': email},
    );
    return response.data['message'];
  }

  @override
  Future<bool> verifyOtp({required String email, required String otp}) async {
    final response = await _api.post(
      '/auth/verify-otp',
      data: {'email': email, 'otp': otp},
    );
    return response.data['success'];
  }

  @override
  Future<String> resetPassword({
    required String email,
    required String newPassword,
  }) async {
    final response = await _api.post(
      '/auth/reset-password',
      data: {'email': email, 'newPassword': newPassword},
    );
    return response.data['message'];
  }

  @override
  Future<void> resendOtp({required String email}) async {
    await _api.post('/auth/resend-otp', data: {'email': email});
  }

  @override
  Future<void> logout() async {
    await _api.post('/auth/logout');
  }
}
