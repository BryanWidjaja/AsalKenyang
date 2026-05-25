import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../network/auth_interceptor.dart';
import '../network/dio_client.dart';
import '../storage/token_storage.dart';

final secureStorageProvider = Provider<FlutterSecureStorage>(
  (ref) => const FlutterSecureStorage(),
);

final tokenStorageProvider = Provider<TokenStorage>(
  (ref) => TokenStorage(ref.watch(secureStorageProvider)),
);

final dioProvider = Provider<Dio>((ref) {
  final dio = createDio();
  dio.interceptors.add(AuthInterceptor(ref.watch(tokenStorageProvider)));
  return dio;
});
