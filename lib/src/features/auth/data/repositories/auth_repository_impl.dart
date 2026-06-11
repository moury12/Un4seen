import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remote;

  AuthRepositoryImpl(this._remote);

  @override
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) => _remote.login(email: email, password: password);

  @override
  Future<String> forgotPassword({required String email}) =>
      _remote.forgotPassword(email: email);

  @override
  Future<bool> verifyOtp({required String email, required String otp}) =>
      _remote.verifyOtp(email: email, otp: otp);

  @override
  Future<String> resetPassword({
    required String email,
    required String newPassword,
  }) => _remote.resetPassword(email: email, newPassword: newPassword);

  @override
  Future<void> resendOtp({required String email}) =>
      _remote.resendOtp(email: email);

  @override
  Future<void> logout() async {
    // TODO: Implement logout
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    // TODO: Implement getCurrentUser
    return null;
  }
}
