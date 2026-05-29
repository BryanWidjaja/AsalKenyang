import 'package:dio/dio.dart';

const _apiHost = String.fromEnvironment(
  'API_URL',
  defaultValue: 'http://localhost:3000',
);

Dio createDio() {
  return Dio(
    BaseOptions(
      baseUrl: '$_apiHost/api/v1',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {'Content-Type': 'application/json'},
    ),
  );
}
