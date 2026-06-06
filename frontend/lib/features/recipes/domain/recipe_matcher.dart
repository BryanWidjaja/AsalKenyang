import '../../../shared/utils/ingredient_groups.dart';
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
        !recipe.bahanKey.any(
          (bahanKey) => selectedPantrySet.any(
            (pantryKey) => ingredientKeysMatch(pantryKey, bahanKey),
          ),
        )) {
      continue;
    }

    if (maxBudget != null && recipe.estPrice > maxBudget) {
      continue;
    }

    if (ownedEquipment != null) {
      final canCook = recipe.alat.every(
        (alat) => ownedEquipment.contains(alat),
      );

      if (!canCook) {
        continue;
      }
    }

    final matched = <String>[];
    final missing = <String>[];
    final scoredKeys = recipe.bahanKey
        .where((bahanKey) => !staples.contains(bahanKey))
        .toList(growable: false);

    for (final bahanKey in recipe.bahanKey) {
      if (pantrySet.any((pantryKey) => ingredientKeysMatch(pantryKey, bahanKey))) {
        matched.add(bahanKey);
      } else {
        missing.add(bahanKey);
      }
    }

    final scoredMatched = scoredKeys
        .where(
          (bahanKey) => selectedPantrySet.any(
            (pantryKey) => ingredientKeysMatch(pantryKey, bahanKey),
          ),
        )
        .length;
    final total = scoredKeys.length;
    final percentage = total == 0 ? 1.0 : (scoredMatched / total);

    matchedList.add(
      MatchedRecipe(
        recipe: recipe,
        matchPercentage: percentage,
        matchedKeys: matched,
        missingKeys: missing,
      ),
    );
  }

  if (sortDesc) {
    matchedList.sort((first, second) {
      final byMatch = second.matchPercentage.compareTo(first.matchPercentage);

      if (byMatch != 0) {
        return byMatch;
      }

      final byMissing = first.missingKeys.length.compareTo(
        second.missingKeys.length,
      );

      if (byMissing != 0) {
        return byMissing;
      }

      return first.recipe.estPrice.compareTo(second.recipe.estPrice);
    });
  }

  return matchedList;
}
