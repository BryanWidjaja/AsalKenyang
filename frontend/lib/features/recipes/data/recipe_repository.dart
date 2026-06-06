import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'recipe_models.dart';

final recipeRepositoryProvider = Provider<RecipeRepository>((ref) {
  return RecipeRepository();
});

class RecipeRepository {
  List<Recipe>? _cachedRecipes;

  Future<List<Recipe>> getAllRecipes() async {
    if (_cachedRecipes != null) {
      return _cachedRecipes!;
    }

    final jsonString = await rootBundle.loadString('assets/data/recipes.json');
    final List<dynamic> jsonList = jsonDecode(jsonString);

    _cachedRecipes = jsonList
        .map((json) => Recipe.fromJson(json))
        .where((recipe) => recipe.imageUrl.trim().isNotEmpty)
        .toList();
    return _cachedRecipes!;
  }

  Future<Recipe?> getRecipeById(String id) async {
    final recipes = await getAllRecipes();
    try {
      return recipes.firstWhere((recipe) => recipe.id == id);
    } catch (_) {
      return null;
    }
  }
}
