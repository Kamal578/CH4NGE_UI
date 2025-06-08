import 'package:ch4nge/core/api/api_service.dart';
import 'package:ch4nge/core/auth/auth_manager.dart';
import 'package:ch4nge/core/utils/exception.dart';
import 'package:dio/dio.dart';

abstract class IAuthenticationDatasource {
  Future<void> register(String email, String password, String name);
  Future<String> login(String email, String password);
  Future<void> logout();
}

class AuthenticationRemote extends IAuthenticationDatasource {
  final ApiService _apiService = ApiService.instance;

  @override
  Future<String> login(String email, String password) async {
    try {
      final response = await _apiService.post(
        '/auth/login',
        data: {
          "email": email,
          "password": password,
        },
      );

      if (response.statusCode == 200) {
        final token = response.data?["token"] ?? response.data?["access_token"];
        final userId =
            response.data?["user"]["user_id"] ?? response.data?["user"]["id"];
        final username = response.data?["user"]["username"] ??
            response.data?["user"]["name"];

        if (token != null) {
          AuthManager.saveToken(token);
          if (userId != null) AuthManager.saveId(userId.toString());
          if (username != null) AuthManager.saveUsername(username);
          return token;
        }
      }
      throw Exception(
          'Login failed: Invalid response. Response: ${response.data}');
    } catch (e) {
      if (e is ApiException) rethrow;
      throw Exception('Login failed: ${e.toString()}');
    }
  }

  @override
  Future<String> register(String email, String password, String name) async {
    try {
      final response = await _apiService.post(
        '/auth/register', // Adjust endpoint as needed
        data: {
          "email": email,
          "username": name,
          "password": password,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data?["token"] != null) {
          await login(email, password);
        } else {
          return 'Registration successful. Please log in to continue.';
        }
        return 'Registration successful';
      }
      throw Exception(
          'Registration failed: Invalid response: ${response.data}');
    } catch (e) {
      if (e is ApiException) rethrow;
      throw Exception('Registration failed: ${e.toString()}');
    }
  }

  @override
  Future<void> logout() async {
    try {
      final response = await _apiService.post(
        '/auth/logout',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${AuthManager.readAuth()}',
          },
          validateStatus: (status) => status! < 500,
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        AuthManager.logout();
        return;
      }

      final errorMessage = response.data?['message'] ?? 'Logout failed';
      throw Exception(
          'Logout failed: $errorMessage. Response: ${response.data}');
    } on ApiException catch (ex) {
      final message = ex.response?.data?['message'] ??
          ex.message ??
          'Network error during logout';
      throw Exception(
          'Logout failed: $message. Response: ${ex.response?.data}');
    }
  }
}
