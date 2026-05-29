import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/db/app_database.dart';
import '../data/favorites_repository.dart';

final favoritesControllerProvider =
    NotifierProvider<FavoritesController, AsyncValue<List<FavoritesTableData>>>(
      FavoritesController.new,
    );

class FavoritesController
    extends Notifier<AsyncValue<List<FavoritesTableData>>> {
  @override
  AsyncValue<List<FavoritesTableData>> build() {
    final repo = ref.watch(favoritesRepositoryProvider);
    final subscription = repo.watchFavorites().listen(
      (favorites) {
        state = AsyncValue.data(favorites);
      },
      onError: (err, stack) {
        state = AsyncValue.error(err, stack);
      },
    );
    ref.onDispose(subscription.cancel);
    return const AsyncValue.loading();
  }

  bool isFavorited(String recipeId) {
    return state.value?.any((f) => f.recipeId == recipeId) ?? false;
  }

  Future<void> toggleFavorite(String recipeId) async {
    final repo = ref.read(favoritesRepositoryProvider);
    final currentFavorites = state.value ?? [];
    final isFavorited = currentFavorites.any((f) => f.recipeId == recipeId);

    try {
      if (isFavorited) {
        await repo.removeFavorite(recipeId);
      } else {
        await repo.addFavorite(recipeId);
      }
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}
