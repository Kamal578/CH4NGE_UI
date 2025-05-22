import 'package:ch4nge/core/network/network_client.dart';
import 'package:ch4nge/core/shared/config.dart';
import 'package:ch4nge/core/utils/exception.dart';
import 'package:dio/dio.dart';

class ApiService {
  static ApiService? _instance;
  late final NetworkClient _networkClient;
  
  ApiService._internal() {
    _networkClient = NetworkClient(config: Config());
  }
  
  static ApiService get instance {
    _instance ??= ApiService._internal();
    return _instance!;
  }
  
  NetworkClient get client => _networkClient;
  
  Future<void> initialize() async {
    await _networkClient.initialize();
  }

  // Generic API methods
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _networkClient.dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _networkClient.dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _networkClient.dio.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _networkClient.dio.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }
}