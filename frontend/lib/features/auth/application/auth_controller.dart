import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/di/providers.dart';
import '../data/auth_models.dart';
import '../data/auth_remote_data_source.dart';
import '../data/auth_repository.dart';

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>(
  (ref) => AuthRemoteDataSource(ref.watch(dioProvider)),
);

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepository(
    ref.watch(authRemoteDataSourceProvider),
    ref.watch(tokenStorageProvider),
  ),
);

class AuthController extends AsyncNotifier<User?> {
  @override
  Future<User?> build() async => null;

  Future<void> register(String email, String password) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => ref.read(authRepositoryProvider).register(email, password),
    );
  }

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => ref.read(authRepositoryProvider).login(email, password),
    );
  }

  Future<void> logout() async {
    await ref.read(authRepositoryProvider).logout();
    state = const AsyncValue.data(null);
  }
}

final authControllerProvider = AsyncNotifierProvider<AuthController, User?>(
  AuthController.new,
);

String authErrorMessage(Object error) {
  if (error is DioException) {
    final code = error.response?.statusCode;
    if (code == 401) return 'Email atau kata sandi salah.';
    if (code == 409) return 'Email sudah terdaftar.';
    if (code == 400) return 'Periksa kembali data yang dimasukkan.';
    if (error.type == DioExceptionType.connectionError ||
        error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.sendTimeout) {
      return 'Tidak dapat terhubung ke server.';
    }
  }
  return 'Terjadi kesalahan. Coba lagi.';
}
