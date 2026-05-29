import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../budget/application/budget_controller.dart';
import '../../pantry/application/pantry_controller.dart';
import '../domain/recipe_matcher.dart';
import 'recipe_providers.dart';

class CookState {
  const CookState({
    this.useBudgetFilter = false,
    this.showOnlyCookable = false,
  });

  final bool useBudgetFilter;
  final bool showOnlyCookable;

  CookState copyWith({bool? useBudgetFilter, bool? showOnlyCookable}) {
    return CookState(
      useBudgetFilter: useBudgetFilter ?? this.useBudgetFilter,
      showOnlyCookable: showOnlyCookable ?? this.showOnlyCookable,
    );
  }
}

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
}

final matchedRecipesProvider = Provider<List<MatchedRecipe>>((ref) {
  final recipesAsync = ref.watch(allRecipesProvider);
  final pantryState = ref.watch(pantryControllerProvider);
  final budgetState = ref.watch(budgetControllerProvider);
  final cookState = ref.watch(cookControllerProvider);

  final recipes = recipesAsync.value ?? [];
  final pantryKeys = pantryState.items.map((e) => e.bahanKey).toList();

  int? maxBudget;
  if (cookState.useBudgetFilter) {
    maxBudget = budgetState.remainingBudget;
    // Don't set negative budget filter
    if (maxBudget < 0) maxBudget = 0;
  }

  return matchRecipes(
    allRecipes: recipes,
    pantryKeys: pantryKeys,
    maxBudget: maxBudget,
    sortDesc: true,
  );
});
