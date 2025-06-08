import 'package:ch4nge/core/shared/config.dart';
import 'package:ch4nge/core/auth/auth_manager.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class NetworkClient {
  late final Dio _dio;
  final Config config;
  bool _isInitialized = false;

  NetworkClient({required this.config}) {
    _dio = Dio(BaseOptions(
      baseUrl: config.apiBaseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      sendTimeout: const Duration(seconds: 10),
    ));
    
    // Add common interceptors
    _setupInterceptors();
  }

  Dio get dio => _dio;
  bool get isInitialized => _isInitialized;

  void _setupInterceptors() {
    // Request interceptor for adding auth token
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = AuthManager.readAuth();
          if (token.isNotEmpty) {
            options.headers["Authorization"] = "Bearer $token";
          }
          options.headers["Content-Type"] = "application/json";
          options.headers["Accept"] = "application/json";
          return handler.next(options);
        },
        onError: (error, handler) {
          // Handle common errors
          if (error.response?.statusCode == 401) {
            // Token expired or invalid - logout user
            AuthManager.logout();
          }
          return handler.next(error);
        },
      ),
    );

    // Logging interceptor
    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      logPrint: (object) => debugPrint('[API] $object'),
    ));
  }

  Future<void> initialize() async {
    // Any additional setup can go here
    _isInitialized = true;
  }
}