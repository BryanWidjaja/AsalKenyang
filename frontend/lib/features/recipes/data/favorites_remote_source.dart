import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/di/providers.dart';

final favoritesRemoteSourceProvider = Provider<FavoritesRemoteSource>((ref) {
  return FavoritesRemoteSource(ref.watch(dioProvider));
});

class FavoritesRemoteSource {
  const FavoritesRemoteSource(this._dio);
  final Dio _dio;

  Future<void> addFavorite(String recipeId) async {
    await _dio.post('/favorites', data: {'recipeId': recipeId});
  }

  Future<void> removeFavorite(String recipeId) async {
    await _dio.delete('/favorites/$recipeId');
  }
}
