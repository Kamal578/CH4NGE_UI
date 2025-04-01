import 'package:ch4nge/core/auth/auth_manager.dart';
import 'package:ch4nge/core/utils/dio.dart';
import 'package:ch4nge/core/utils/exception.dart';
import 'package:dio/dio.dart';

abstract class IAuthenticationDatasource {
  Future<void> register(
      String email, String password, String confirmPassword, String name);
  Future<String> login(String email, String password);
}

class AuthenticationRemote extends IAuthenticationDatasource {
  final Dio _dio = DioProvider.createDioWithoutHeader();
  
  @override
  Future<String> login(String email, String password) async {
    try {
      final response = await _dio.post(
        'collections/users/records',
        data: {
          "email": email,
          "password": password,
        },
      );
      if (response.statusCode == 200) {
        AuthManager.saveToken(response.data?["token"]);
        return response.data?["token"];
      }
    } on DioException catch (ex) {
      throw ApiException(ex.response?.data["message"], ex.response);
    }
    return '';
  }

  @override
  Future<void> register(String email, String password, String confirmPassword,
      String name) async {
    try {
      final response = await _dio.post(
        'collections/users/records',
        data: {
          "email": email,
          "username": name,
          "password": password,
          "confirm_password": confirmPassword,
        },
      );
      if (response.statusCode == 200) {
        login(email, password);
      }
    } on DioException catch (ex) {
      throw ApiException(ex.response?.data["message"], ex.response);
    }
  }
}
