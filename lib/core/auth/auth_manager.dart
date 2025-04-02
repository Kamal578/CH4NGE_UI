import 'package:ch4nge/core/di/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthManager {
  static final ValueNotifier<String?> authChangeNotifier = ValueNotifier(null);
  static final SharedPreferences _sharedPreferences = serviceLocator.get();

  static void saveToken(String token) {
    _sharedPreferences.setString('access_token', token);
    authChangeNotifier.value = token;
  }

  static void saveId(String id) async {
    _sharedPreferences.setString('user_id', id);
  }

  static String getId() {
    return _sharedPreferences.getString('user_id') ?? '';
  }

  static void saveUsername(String username) {
    _sharedPreferences.setString('username', username);
  }

  static String getUsername() {
    return _sharedPreferences.getString('username') ?? '';
  }

  static String readAuth() {
    return _sharedPreferences.getString('access_token') ?? '';
  }

  static void logout() {
    _sharedPreferences.clear();
    authChangeNotifier.value = null;
  }

  static bool isLogedin() {
    String token = readAuth();
    return token.isNotEmpty;
  }
}
