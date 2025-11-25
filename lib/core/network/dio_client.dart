import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import '../utils/pref_helper.dart';

class DioClient {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://sonic-zdi0.onrender.com/api',
      headers: {"Content-Type": 'application/json'},
    ),
  );

  DioClient() {
    // _dio.interceptors.add(
    //   LogInterceptor(requestBody: true, responseBody: true),
    // );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await PrefHelper.getToken();
          debugPrint(' API Request to: ${options.path}');
          debugPrint(' Token for request: ${token ?? 'null'}');

          if (token != null && token.isNotEmpty && token != 'guest') {
            options.headers['Authorization'] = 'Bearer $token';
            debugPrint('Authorization header added');
          } else {
            debugPrint('No authorization header added');
          }
          return handler.next(options);
        },
      ),
    );
  }

  Dio get dio => _dio;
}