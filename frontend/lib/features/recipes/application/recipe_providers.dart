import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/recipe_models.dart';
import '../data/recipe_repository.dart';
import '../application/favorites_controller.dart';

final allRecipesProvider = FutureProvider<List<Recipe>>((ref) async {
  final repo = ref.watch(recipeRepositoryProvider);
  return repo.getAllRecipes();
});

final recipeSearchQueryProvider = NotifierProvider<RecipeSearchQueryNotifier, String>(RecipeSearchQueryNotifier.new);

class RecipeSearchQueryNotifier extends Notifier<String> {
  @override
  String build() => '';
  void updateState(String value) => state = value;
}

final recipeFilterProvider = NotifierProvider<RecipeFilterNotifier, String>(RecipeFilterNotifier.new);

class RecipeFilterNotifier extends Notifier<String> {
  @override
  String build() => 'Semua';
  void updateState(String value) => state = value;
}

final filteredRecipesProvider = Provider<AsyncValue<List<Recipe>>>((ref) {
  final recipesAsync = ref.watch(allRecipesProvider);
  final query = ref.watch(recipeSearchQueryProvider).toLowerCase();
  final filter = ref.watch(recipeFilterProvider);

  return recipesAsync.whenData((recipes) {
    return recipes.where((recipe) {
      if (filter != 'Semua') {
        if (filter == 'Rice Cooker Aja' &&
            !recipe.alat.contains('rice cooker')) {
          return false;
        }

        if (filter == 'Tanpa Kompor' && recipe.alat.contains('kompor')) {
          return false;
        }

        if (filter == '<Rp 10rb' && recipe.estPrice >= 10000) {
          return false;
        }

        if (filter == 'Kilat' && recipe.cookTime > 15) {
          return false;
        }
      }

      if (query.isNotEmpty && !recipe.name.toLowerCase().contains(query)) {
        return false;
      }

      return true;
    }).toList();
  });
});

final favoritedRecipesProvider = Provider<AsyncValue<List<Recipe>>>((ref) {
  final recipesAsync = ref.watch(allRecipesProvider);
  final favoritesAsync = ref.watch(favoritesControllerProvider);

  if (recipesAsync is AsyncLoading || favoritesAsync is AsyncLoading) {
    return const AsyncValue.loading();
  }
  if (recipesAsync is AsyncError) {
    return AsyncValue.error(recipesAsync.error!, recipesAsync.stackTrace!);
  }
  if (favoritesAsync is AsyncError) {
    return AsyncValue.error(favoritesAsync.error!, favoritesAsync.stackTrace!);
  }

  final recipes = recipesAsync.value!;
  final favorites = favoritesAsync.value!;
  final favoriteIds = favorites.map((favorite) => favorite.recipeId).toSet();

  return AsyncValue.data(
    recipes.where((recipe) => favoriteIds.contains(recipe.id)).toList(),
  );
});
