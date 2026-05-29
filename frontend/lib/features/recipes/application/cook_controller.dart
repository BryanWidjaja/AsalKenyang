import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../budget/application/budget_controller.dart';
import '../../pantry/application/pantry_controller.dart';
import '../domain/recipe_matcher.dart';
import 'recipe_providers.dart';

class CookState {
  const CookState({
    this.useBudgetFilter = false,
    this.showOnlyCookable = false,
    this.selectedIngredientKeys,
  });

  final bool useBudgetFilter;
  final bool showOnlyCookable;
  final Set<String>? selectedIngredientKeys;

  CookState copyWith({
    bool? useBudgetFilter,
    bool? showOnlyCookable,
    Object? selectedIngredientKeys = _keepSelectedIngredientKeys,
  }) {
    return CookState(
      useBudgetFilter: useBudgetFilter ?? this.useBudgetFilter,
      showOnlyCookable: showOnlyCookable ?? this.showOnlyCookable,
      selectedIngredientKeys:
          selectedIngredientKeys == _keepSelectedIngredientKeys
          ? this.selectedIngredientKeys
          : selectedIngredientKeys as Set<String>?,
    );
  }
}

const _keepSelectedIngredientKeys = Object();

final cookControllerProvider = NotifierProvider<CookController, CookState>(
  CookController.new,
);

class CookController extends Notifier<CookState> {
  @override
  CookState build() {
    return const CookState();
  }

  void toggleBudgetFilter(bool val) {
    state = state.copyWith(useBudgetFilter: val);
  }

  void toggleCookableFilter(bool val) {
    state = state.copyWith(showOnlyCookable: val);
  }

  void toggleIngredient(String bahanKey, Iterable<String> fallbackKeys) {
    final selected = Set<String>.from(
      state.selectedIngredientKeys ?? fallbackKeys,
    );
    if (selected.contains(bahanKey)) {
      selected.remove(bahanKey);
    } else {
      selected.add(bahanKey);
    }
    state = state.copyWith(selectedIngredientKeys: Set.unmodifiable(selected));
  }
}

final matchedRecipesProvider = Provider<List<MatchedRecipe>>((ref) {
  final recipesAsync = ref.watch(allRecipesProvider);
  final pantryState = ref.watch(pantryControllerProvider);
  final budgetState = ref.watch(budgetControllerProvider);
  final cookState = ref.watch(cookControllerProvider);

  final recipes = recipesAsync.value ?? [];
  final pantryKeys = pantryState.items.map((e) => e.bahanKey).toList();
  final selectedKeys = cookState.selectedIngredientKeys ?? pantryKeys;

  int? maxBudget;
  if (cookState.useBudgetFilter) {
    maxBudget = budgetState.remainingBudget;
    // Don't set negative budget filter
    if (maxBudget < 0) maxBudget = 0;
  }

  return matchRecipes(
    allRecipes: recipes,
    pantryKeys: selectedKeys.toList(),
    maxBudget: maxBudget,
    sortDesc: true,
  );
});
