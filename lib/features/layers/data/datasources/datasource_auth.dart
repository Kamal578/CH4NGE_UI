import 'package:ch4nge/core/auth/auth_manager.dart';
import 'package:ch4nge/core/utils/dio.dart';
import 'package:ch4nge/core/utils/exception.dart';
import 'package:dio/dio.dart';

abstract class IAuthenticationDatasource {
  Future<void> register(String email, String password, String name);
  Future<String> login(String email, String password);
  Future<void> logout();
}

class AuthenticationRemote extends IAuthenticationDatasource {
  final Dio _dio = DioProvider.createDioWithoutHeader();
  final _mockUser = {
    'user_id': '12345',
    'email': 'd.kuramshin@ufaz.az',
    'password': 'Qwerty123@',
    'username': 'Dima',
    'token': 'mock_jwt_token_12345'
  };

  @override
  Future<String> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay

    if (email == _mockUser['email'] && password == _mockUser['password']) {
      AuthManager.saveToken(_mockUser['token']!);
      AuthManager.saveId(_mockUser['user_id']!);
      AuthManager.saveUsername(_mockUser['username']!);
      return _mockUser['token']!;
    }
    throw ApiException('Invalid credentials', null);
  }

  // TODO: Uncomment this section to use the actual API
  // @override
  // Future<String> login(String email, String password) async {
  //   try {
  //     final response = await _dio.post(
  //       'collections/users/records',
  //       data: {
  //         "email": email,
  //         "password": password,
  //       },
  //     );
  //     if (response.statusCode == 200) {
  //       AuthManager.saveToken(response.data?["token"]);
  //       return response.data?["token"];
  //     }
  //   } on DioException catch (ex) {
  //     throw ApiException(ex.response?.data["message"], ex.response);
  //   }
  //   return '';
  // }

  @override
  Future<String> register(String email, String password, String name) async {
    await Future.delayed(const Duration(seconds: 1));

    final normalizedEmail = email.trim().toLowerCase();
    final normalizedName = name.trim().toLowerCase();
    final mockEmail = _mockUser['email']!.toLowerCase();
    final mockName = _mockUser['username']!.toLowerCase();
    final mockPassword = _mockUser['password']!; // Case-sensitive

    // Simulate successful registration
    if (password == mockPassword &&
        normalizedEmail == 'd.kuramshin@ufaz.az' &&
        normalizedName == 'dima') {
      await login(email, password);
      return 'Registration successful';
    }

    if (normalizedEmail == mockEmail) {
      throw ApiException('Email is already registered', null);
    }

    if (normalizedName == mockName) {
      throw ApiException('Username is already taken', null);
    }

    throw ApiException('Registration failed', null);
  }

  // TODO: Uncomment this section to use the actual API
  // @override
  // Future<void> register(String email, String password,
  //     String name) async {
  //   try {
  //     final response = await _dio.post(
  //       'collections/users/records',
  //       data: {
  //         "email": email,
  //         "username": name,
  //         "password": password,
  //       },
  //     );
  //     if (response.statusCode == 200) {
  //       login(email, password);
  //     }
  //   } on DioException catch (ex) {
  //     throw ApiException(ex.response?.data["message"], ex.response);
  //   }
  // }
  @override
  Future<void> logout() async {
    await Future.delayed(const Duration(seconds: 1));
    AuthManager.logout();
  }

  // TODO: Uncomment this section to use the actual API
  // @override
  // Future<void> logout() async {
  //   try {
  //     final response = await _dio.post(
  //       '/api/users/logout',
  //       options: Options(
  //         headers: {
  //           'Authorization': 'Bearer ${AuthManager.readAuth()}',
  //         },
  //         validateStatus: (status) => status! < 500,
  //       ),
  //     );

  //     if (response.statusCode! >= 200 && response.statusCode! < 300) {
  //       AuthManager.logout();
  //       return;
  //     }

  //     final errorMessage = response.data?['message'] ?? 'Logout failed';
  //     throw ApiException(errorMessage, response);
  //   } on DioException catch (ex) {
  //     final message = ex.response?.data?['message'] ??
  //         ex.message ??
  //         'Network error during logout';
  //     throw ApiException(message, ex.response);
  //   }
  // }
}
