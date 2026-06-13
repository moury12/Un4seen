import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;
import 'local_storage_service.dart';

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      // baseUrl: 'http://10.10.28.81:5011/api/v1',
      baseUrl: 'https://un4seen-backend.vercel.app/api/v1',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      contentType: 'application/json',
    ),
  );

  final LocalStorageService _storage = getx.Get.find<LocalStorageService>();

  ApiService() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          log(" token ------------  ${_storage.accessToken ?? "NULL"}");
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
      ),
    );
  }
  void _logRequest(RequestOptions o) {
    print('🚀 [API REQUEST] | ${o.method} | ${o.path}');
    print('🔗 File: lib/src/core/services/api_service.dart');

    if (o.data != null) {
      if (o.data is FormData) {
        final formData = o.data as FormData;
        print('📦 [BODY - FormData Fields]:');
        for (var field in formData.fields) {
          // This will show your "data" JSON string: {"year": "2024", "make": "Honda"...}
          print('   ➤ ${field.key}: ${field.value}');
        }
        print('📂 [BODY - FormData Files]:');
        for (var file in formData.files) {
          // This will show your "image" field and filename
          print('   ➤ ${file.key}: ${file.value.filename}');
        }
      } else {
        // Standard JSON body (Map or String)
        print('📦 [BODY]: ${o.data}');
      }
    } else {
      print('📦 [BODY]: Empty');
    }
  }

  void _logResponse(Response r) {
    print('✅ [API RESPONSE] | ${r.statusCode} | ${r.requestOptions.path}');
    print('🔗 File: lib/src/core/services/api_service.dart:51');
    print('📄 Data: ${r.data}');
  }

  void _logError(DioException e) {
    print(
      '❌ [API ERROR] | ${e.response?.statusCode} | ${e.requestOptions.path}',
    );
    print('🔗 File: lib/src/core/services/api_service.dart:57');
    print('💬 Response: ${e.response?.data}');
  }

  Future<Response> post(String path, {dynamic data}) async {
    try {
      return await _dio.post(
        path,
        data: data,
        options: Options(validateStatus: (status) => status! < 500),
      );
    } on DioException {
      rethrow;
    }
  }

  Future<Response> patch(String path, {dynamic data}) async {
    try {
      return await _dio.patch(
        path,
        data: data,
        options: Options(validateStatus: (status) => status! < 500),
      );
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
