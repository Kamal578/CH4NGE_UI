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
  // final _mockUser = {
  //   'user_id': '12345',
  //   'email': 'd.kuramshin@ufaz.az',
  //   'password': 'Qwerty123@',
  //   'username': 'Dima',
  //   'token': 'mock_jwt_token_12345'
  // };

  // @override
  // Future<String> login(String email, String password) async {
  //   await Future.delayed(const Duration(seconds: 1)); // Simulate network delay

  //   if (email == _mockUser['email'] && password == _mockUser['password']) {
  //     AuthManager.saveToken(_mockUser['token']!);
  //     AuthManager.saveId(_mockUser['user_id']!);
  //     AuthManager.saveUsername(_mockUser['username']!);
  //     return _mockUser['token']!;
  //   }
  //   throw Exception('Invalid credentials');
  // }

  // TODO: Uncomment when API is ready
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
        final userId = response.data?["user_id"] ?? response.data?["id"];
        final username = response.data?["username"] ?? response.data?["name"];

        if (token != null) {
          AuthManager.saveToken(token);
          if (userId != null) AuthManager.saveId(userId.toString());
          if (username != null) AuthManager.saveUsername(username);
          return token;
        }
      }
      throw Exception('Login failed: Invalid response. Response: ${response.data}');
        } catch (e) {
      if (e is ApiException) rethrow;
      throw Exception('Login failed: ${e.toString()}');
    }
  }

  // TODO: Comment when API is ready
  // @override
  // Future<String> register(String email, String password, String name) async {
  //   await Future.delayed(const Duration(seconds: 1));

  //   final normalizedEmail = email.trim().toLowerCase();
  //   final normalizedName = name.trim().toLowerCase();
  //   final mockEmail = _mockUser['email']!.toLowerCase();
  //   final mockName = _mockUser['username']!.toLowerCase();
  //   final mockPassword = _mockUser['password']!; // Case-sensitive

  //   // Simulate successful registration
  //   if (password == mockPassword &&
  //       normalizedEmail == 'd.kuramshin@ufaz.az' &&
  //       normalizedName == 'dima') {
  //     await login(email, password);
  //     return 'Registration successful';
  //   }

  //   if (normalizedEmail == mockEmail) {
  //     throw Exception('Email is already registered');
  //   }

  //   if (normalizedName == mockName) {
  //     throw Exception('Username is already taken');
  //   }

  //   throw Exception('Registration failed');
  // }

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
      throw Exception('Registration failed: Invalid response: ${response.data}');
    } catch (e) {
      if (e is ApiException) rethrow;
      throw Exception('Registration failed: ${e.toString()}');
    }
  }

  // @override
  // Future<void> logout() async {
  //   await Future.delayed(const Duration(seconds: 1));
  //   AuthManager.logout();
  // }

  // TODO: Uncomment when API is ready
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
      throw Exception('Logout failed: $errorMessage. Response: ${response.data}');
    } on ApiException catch (ex) {
      final message = ex.response?.data?['message'] ??
          ex.message ??
          'Network error during logout';
      throw Exception('Logout failed: $message. Response: ${ex.response?.data}');
    }
  }
}
