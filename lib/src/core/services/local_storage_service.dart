import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';

  late SharedPreferences _prefs;

  Future<LocalStorageService> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  Future<void> saveTokens(String access, String refresh) async {
    await _prefs.setString(_accessTokenKey, access);
    await _prefs.setString(_refreshTokenKey, refresh);
  }

  String? get accessToken => _prefs.getString(_accessTokenKey);
  String? get refreshToken => _prefs.getString(_refreshTokenKey);

  Future<void> clear() async {
    await _prefs.remove(_accessTokenKey);
    await _prefs.remove(_refreshTokenKey);
  }
}
