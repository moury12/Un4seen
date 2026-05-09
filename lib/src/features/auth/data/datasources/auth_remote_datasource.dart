import '../models/user_model.dart';

// Replace with your actual ApiService / Dio client
abstract class AuthRemoteDataSource {
  Future<UserModel> login({required String email, required String password});
  Future<void> logout();
  Future<UserModel?> getCurrentUser();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  // final ApiService _api;
  // AuthRemoteDataSourceImpl(this._api);

  @override
  Future<UserModel> login({required String email, required String password}) async {
    // Simulate network call
    await Future.delayed(const Duration(seconds: 1));
    // TODO: replace with real API call
    return UserModel(id: '1', email: email, name: 'Demo User');
  }

  @override
  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 300));
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    return null;
  }
}
