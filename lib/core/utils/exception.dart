import 'package:dio/dio.dart';

class ApiException implements Exception {
  final String? message;
  final Response<dynamic>? response;

  ApiException._(this.message, this.response);

  /// Factory constructor that handles DioException and returns an ApiException
  factory ApiException.fromDioException(DioException e) {
    String message;

    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        message = 'Connection timeout';
        break;
      case DioExceptionType.sendTimeout:
        message = 'Send timeout';
        break;
      case DioExceptionType.receiveTimeout:
        message = 'Receive timeout';
        break;
      case DioExceptionType.badResponse:
        message = e.response?.data?['message'] ?? 
                  'Server error: ${e.response?.statusCode}';
        break;
      case DioExceptionType.cancel:
        message = 'Request cancelled';
        break;
      case DioExceptionType.unknown:
        message = 'Network error: ${e.message}';
        break;
      default:
        message = 'Something went wrong';
    }

    // Create the initial exception
    final exception = ApiException._(message, e.response);
    return exception._refineMessage();
  }

  /// Refine specific cases after initial creation
  ApiException _refineMessage() {
    String? refinedMessage = message;

    if (message == "Failed to authenticate.") {
      refinedMessage = "Invalid username or password";
    }

    if (message == "Failed to create record.") {
      final data = response?.data?["data"];
      if (data?["username"]?["message"] == "The username is invalid or already in use.") {
        refinedMessage = "Username is already in use";
      } else if (data?["email"]?["message"] == "The email is invalid or already in use.") {
        refinedMessage = "Email is already in use";
      }
    }

    return ApiException._(refinedMessage, response);
  }

  @override
  String toString() => message ?? 'ApiException';
}
