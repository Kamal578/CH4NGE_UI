import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioProvider {
  static Dio createDio({String? baseUrl}) {
    final dio = Dio(BaseOptions(
      baseUrl: baseUrl ?? "https://api.github.com",
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      sendTimeout: const Duration(seconds: 10),
    ));
    
    // Add logging interceptor for debugging
    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      logPrint: (object) => debugPrint(object as String?),
    ));
    
    return dio;
  }
}