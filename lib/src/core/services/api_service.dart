import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;
import 'local_storage_service.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'http://10.10.10.106:5011/api/v1',
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
    contentType: 'application/json',
  ));

  final LocalStorageService _storage = getx.Get.find<LocalStorageService>();

  ApiService() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        final token = _storage.accessToken;
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        _logRequest(options);
        return handler.next(options);
      },
      onResponse: (response, handler) {
        _logResponse(response);
        return handler.next(response);
      },
      onError: (DioException e, handler) async {
        _logError(e);
        // Handle token refresh on 401
        if (e.response?.statusCode == 401) {
          final refresh = _storage.refreshToken;
          if (refresh != null) {
            try {
              final refreshRes = await Dio().post(
                '${_dio.options.baseUrl}/auth/refresh-token',
                data: {'refreshToken': refresh},
              );

              final newAccess = refreshRes.data['data']['accessToken'];
              final newRefresh = refreshRes.data['data']['refreshToken'];
              await _storage.saveTokens(newAccess, newRefresh);

              e.requestOptions.headers['Authorization'] = 'Bearer $newAccess';
              return handler.resolve(await _dio.fetch(e.requestOptions));
            } catch (refreshError) {
              await _storage.clear();
            }
          }
        }
        return handler.next(e);
      },
    ));
  }

  void _logRequest(RequestOptions o) {
    print('🚀 [API REQUEST] | ${o.method} | ${o.path}');
    print('🔗 File: lib/src/core/services/api_service.dart:45');
    if (o.data != null) print('📦 Body: ${o.data}');
  }

  void _logResponse(Response r) {
    print('✅ [API RESPONSE] | ${r.statusCode} | ${r.requestOptions.path}');
    print('🔗 File: lib/src/core/services/api_service.dart:51');
    print('📄 Data: ${r.data}');
  }

  void _logError(DioException e) {
    print('❌ [API ERROR] | ${e.response?.statusCode} | ${e.requestOptions.path}');
    print('🔗 File: lib/src/core/services/api_service.dart:57');
    print('💬 Response: ${e.response?.data}');
  }

  Future<Response> post(String path, {dynamic data}) async {
    try {
      return await _dio.post(path,
          data: data,
          options: Options(validateStatus: (status) => status! < 500));
    } on DioException {
      rethrow;
    }
  }

  Future<Response> patch(String path, {dynamic data}) async {
    try {
      return await _dio.patch(path,
          data: data,
          options: Options(validateStatus: (status) => status! < 500));
    } on DioException {
      rethrow;
    }
  }

  Future<Response> get(String path) async {
    try {
      return await _dio.get(path);
    } on DioException {
      rethrow;
    }
  }
}
