import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../recipes/application/recipe_providers.dart';
import '../../recipes/data/recipe_models.dart';
import '../data/plan_models.dart';
import '../data/plan_repository.dart';

final planStreamProvider = StreamProvider<List<PlannedMeal>>((ref) {
  return ref.watch(planRepositoryProvider).watchPlan();
});

class PlannedMealDetail {
  const PlannedMealDetail({required this.meal, required this.recipe});
  final PlannedMeal meal;
  final Recipe recipe;
}

final planDetailsProvider = Provider<List<PlannedMealDetail>>((ref) {
  final meals = ref.watch(planStreamProvider).value ?? [];
  final recipes = ref.watch(allRecipesProvider).value ?? [];

  return meals.map((meal) {
    final recipe = recipes.firstWhere(
      (r) => r.id == meal.recipeId,
      orElse: () => const Recipe(
        id: '',
        name: 'Unknown Recipe',
        kategori: '',
        porsi: 1,
        estPrice: 0,
        estCalories: 0,
        cookTime: 0,
        imageUrl: '',
        alat: [],
        bahan: [],
        bahanKey: [],
        langkah: [],
        tags: [],
        halal: true,
      ),
    );
    return PlannedMealDetail(meal: meal, recipe: recipe);
  }).toList();
});

final planControllerProvider = Provider<PlanController>((ref) {
  return PlanController(ref.watch(planRepositoryProvider));
});

class PlanController {
  PlanController(this._repo);
  final PlanRepository _repo;

  Future<void> addMeal(DateTime date, String recipeId, String mealSlot) async {
    final day = DateTime(date.year, date.month, date.day);
    final timestamp = DateTime.now().microsecondsSinceEpoch;
    final id = '${day.toIso8601String()}_${timestamp}_$recipeId';
    await _repo.addMeal(PlannedMeal(id: id, date: day, recipeId: recipeId, mealSlot: mealSlot));
  }

  Future<void> removeMeal(String id) async {
    await _repo.removeMeal(id);
  }
}
