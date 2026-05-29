import '../data/recipe_models.dart';

class MatchedRecipe {
  const MatchedRecipe({
    required this.recipe,
    required this.matchPercentage,
    required this.matchedKeys,
    required this.missingKeys,
  });

  final Recipe recipe;
  final double matchPercentage;
  final List<String> matchedKeys;
  final List<String> missingKeys;
}

/// Pure function to match recipes against pantry and budget.
List<MatchedRecipe> matchRecipes({
  required List<Recipe> allRecipes,
  required List<String> pantryKeys,
  int? maxBudget,
  Set<String>? ownedEquipment,
  bool sortDesc = true,
}) {
  const staples = {
    'air',
    'garam',
    'gula',
    'gula pasir',
    'merica',
    'minyak',
    'minyak goreng',
  };
  final selectedPantrySet = pantryKeys.toSet();
  final pantrySet = {...selectedPantrySet, ...staples};

  final matchedList = <MatchedRecipe>[];

  for (final recipe in allRecipes) {
    if (selectedPantrySet.isNotEmpty &&
        !recipe.bahanKey.any(selectedPantrySet.contains)) {
      continue;
    }

    // 1. Budget check
    if (maxBudget != null && recipe.estPrice > maxBudget) {
      continue;
    }

    // 1.5 Equipment check
    if (ownedEquipment != null) {
      final canCook = recipe.alat.every(
        (alat) => ownedEquipment.contains(alat),
      );
      if (!canCook) continue;
    }

    // 2. Ingredients match
    final matched = <String>[];
    final missing = <String>[];
    final scoredKeys = recipe.bahanKey
        .where((bKey) => !staples.contains(bKey))
        .toList(growable: false);
    for (final bKey in recipe.bahanKey) {
      if (pantrySet.contains(bKey)) {
        matched.add(bKey);
      } else {
        missing.add(bKey);
      }
    }

    final scoredMatched = scoredKeys
        .where((bKey) => selectedPantrySet.contains(bKey))
        .length;
    final total = scoredKeys.length;
    final pct = total == 0 ? 1.0 : (scoredMatched / total);

    matchedList.add(
      MatchedRecipe(
        recipe: recipe,
        matchPercentage: pct,
        matchedKeys: matched,
        missingKeys: missing,
      ),
    );
  }

  // 3. Sort by match percentage
  if (sortDesc) {
    matchedList.sort((a, b) {
      final byMatch = b.matchPercentage.compareTo(a.matchPercentage);
      if (byMatch != 0) return byMatch;
      final byMissing = a.missingKeys.length.compareTo(b.missingKeys.length);
      if (byMissing != 0) return byMissing;
      return a.recipe.estPrice.compareTo(b.recipe.estPrice);
    });
  }

  return matchedList;
}
