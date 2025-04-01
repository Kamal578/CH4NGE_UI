import 'package:dio/dio.dart';

class ApiException implements Exception {
  String? message;
  Response<dynamic>? response;

  ApiException(this.message, this.response) {
    if (message == "Failed to authenticate.") {
      message = "Invalid username or password";
    }
    if (message == "Failed to create record.") {
      if (response?.data["data"]["username"] != null) {
        if (response?.data["data"]["username"]["message"] == "The username is invalid or already in use.") {
          message = "Username is already in use";
        }
      }
      if (response?.data["data"]["email"] != null) {
        if (response?.data["data"]["email"]["message"] == "The email is invalid or already in use.") {
          message = "Email is already in use";
        }
      }
    }
  }
}
