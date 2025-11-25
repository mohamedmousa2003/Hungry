class ApiError {
  //? error in postman
  final String message;
  final int? statusCode;

  ApiError({required this.message ,this.statusCode });

  @override
  String toString() {
    return '$message (status code $statusCode)';
  }
}