import 'package:ch4nge/core/shared/config.dart';
import 'package:dio/dio.dart';

class NetworkClient {
  final Dio _dio;
  final Config config;
  NetworkClient(this._dio, {required this.config}) {
    _dio.options = BaseOptions(baseUrl: config.apiBaseUrl);
  }

  Dio get dio => _dio;

  Future<void> initialize({required String token}) async {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.headers["Authorization"] = "Token $token";
          return handler.next(options);
        },
      ),
    );
  }
}