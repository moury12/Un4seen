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
          log(
            " refresh token --------------- ${_storage.refreshToken ?? "NULL"}",
          );
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
        onError: 
         (DioException e, handler) async {
          _logError(e);

          // ─── 401 UNAUTHORIZED / TOKEN EXPIRED LOGIC ───
          if (e.response?.statusCode == 401) {
            final String? currentRefreshToken = _storage.refreshToken;

            if (currentRefreshToken != null && currentRefreshToken.isNotEmpty) {
              try {
                log("🔄 [TOKEN] 401 Detected. Attempting to refresh access token...");
                
                // Use a clean Dio instance to avoid interceptor loops
                final refreshRes = await Dio().post(
                  '${_dio.options.baseUrl}/auth/refresh-token',
                  data: {'refreshToken': currentRefreshToken},
                );

                if (refreshRes.statusCode == 200 && refreshRes.data['success'] == true) {
                  final String newAccessToken = refreshRes.data['data']['accessToken'];
                  
                  log("✅ [TOKEN] New access token retrieved. Updating storage.");
                  
                  // Save the new access token. 
                  // Note: Since the refresh API only returns accessToken, 
                  // we pass the existing refreshToken back into saveTokens to keep it.
                  await _storage.saveTokens(newAccessToken, currentRefreshToken);

                  // Update the header of the original failed request
                  e.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';

                  // Retry the original request
                  log("🔁 [RETRY] Retrying original request: ${e.requestOptions.path}");
                  final clonedRequest = await _dio.fetch(e.requestOptions);
                  return handler.resolve(clonedRequest);
                }
              } catch (refreshError) {
                log("🚨 [TOKEN] Refresh failed or Refresh Token expired. Clearing session.");
                await _storage.clear();
                // Optional: Trigger a redirect to login page here if using a global controller
              }
            } else {
              log("🚨 [TOKEN] No refresh token available. User must login again.");
              await _storage.clear();
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
