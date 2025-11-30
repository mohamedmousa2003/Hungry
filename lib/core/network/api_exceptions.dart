import 'package:dio/dio.dart';
import 'api_error.dart';

class ApiExceptions {
  /// Handles Dio errors and returns a structured ApiError
  static ApiError handleError(DioException error) {
    final statusCode = error.response?.statusCode;
    final data = error.response?.data;

    // 1️⃣ Check if server returned a message
    if (statusCode != null && data is Map<String, dynamic>) {
      final message = data['message'] ?? data['error'] ?? data['msg'];
      if (message != null) {
        return ApiError(message: message, statusCode: statusCode);
      }
    }

    // 2️⃣ Specific status code handling
    if (statusCode == 302) {
      return ApiError(message: 'This email is already taken', statusCode: statusCode);
    }

    if (statusCode == 401) {
      return ApiError(message: 'Unauthorized. Please login again', statusCode: statusCode);
    }

    if (statusCode == 400) {
      return ApiError(message: 'Bad request. Please check your input', statusCode: statusCode);
    }

    if (statusCode == 500) {
      return ApiError(message: 'Server error. Please try again later', statusCode: statusCode);
    }

    // 3️⃣ Network / timeout errors
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return ApiError(
          message: "Connection timeout. Please check your internet connection",
        );
      case DioExceptionType.sendTimeout:
        return ApiError(
          message: "Request timeout. Please try again",
        );
      case DioExceptionType.receiveTimeout:
        return ApiError(
          message: "Response timeout. Please try again",
        );
      case DioExceptionType.cancel:
        return ApiError(
          message: "Request was cancelled. Please try again",
        );
      case DioExceptionType.unknown:
        return ApiError(
          message: "No internet connection. Please check your network",
        );
      default:
        return ApiError(
          message: "An unexpected error occurred. Please try again",
        );
    }
  }
}














// if(statusCode == 302) {
//   return ApiError(message: 'The Email is Already Taken');
// }

// print('Error response: ${error.response?.data}');
// print('Status code: $statusCode');