import 'package:dio/dio.dart';

import 'auth_models.dart';

class AuthRemoteDataSource {
  AuthRemoteDataSource(this._dio);

  final Dio _dio;

  Future<AuthResponse> register(String email, String password) async {
    final res = await _dio.post<Map<String, dynamic>>(
      '/auth/register',
      data: {'email': email, 'password': password},
    );
    return AuthResponse.fromJson(res.data!);
  }

  Future<AuthResponse> login(String email, String password) async {
    final res = await _dio.post<Map<String, dynamic>>(
      '/auth/login',
      data: {'email': email, 'password': password},
    );
    return AuthResponse.fromJson(res.data!);
  }
}
