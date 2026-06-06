import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/filter_pill.dart';
import '../../../shared/widgets/match_result_row.dart';
import '../../../shared/widgets/top_bar.dart';
import '../application/cook_controller.dart';
import '../application/recipe_providers.dart';
import 'recipe_detail_page.dart';

class SearchResultsPage extends ConsumerStatefulWidget {
  const SearchResultsPage({super.key});

  static const String route = '/search-results';

  @override
  ConsumerState<SearchResultsPage> createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends ConsumerState<SearchResultsPage> {
  String _sort = 'Kecocokan Tertinggi';

  @override
  Widget build(BuildContext context) {
    final recipesAsync = ref.watch(allRecipesProvider);
    final matchedRecipes = ref.watch(matchedRecipesProvider);
    final cookState = ref.watch(cookControllerProvider);
    final visibleMatches = [
      for (final match in matchedRecipes)
        if (!cookState.showOnlyCookable || match.missingKeys.isEmpty) match,
    ];
    if (_sort == 'Waktu Singkat') {
      visibleMatches.sort(
        (first, second) => first.recipe.cookTime.compareTo(second.recipe.cookTime),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.riceWhite,
      appBar: const TopBar.nested(title: 'Resep'),
      body: SafeArea(
        top: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: AppSpacing.screenMaxWidth,
            ),
            child: recipesAsync.when(
              data: (recipes) => ListView(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.edge,
                  AppSpacing.md,
                  AppSpacing.edge,
                  AppSpacing.xl,
                ),
                children: [
                  Text(
                    'Ditemukan ${visibleMatches.length} resep',
                    style: AppTypography.titleMd,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    '${matchedRecipes.where((match) => match.missingKeys.isEmpty).length} bisa dimasak sekarang. Sisanya perlu belanja bahan.',
                    style: AppTypography.body.copyWith(
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text('Filter', style: AppTypography.caption),
                  const SizedBox(height: AppSpacing.xs),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        FilterPill(
                          label: 'Bisa dimasak',
                          icon: Icons.restaurant_rounded,
                          selected: cookState.showOnlyCookable,
                          onTap: () => ref
                              .read(cookControllerProvider.notifier)
                              .toggleCookableFilter(
                                !cookState.showOnlyCookable,
                              ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        FilterPill(
                          label: 'Sesuai budget',
                          icon: Icons.payments_rounded,
                          selected: cookState.useBudgetFilter,
                          onTap: () => ref
                              .read(cookControllerProvider.notifier)
                              .toggleBudgetFilter(!cookState.useBudgetFilter),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text('Urutkan', style: AppTypography.caption),
                  const SizedBox(height: AppSpacing.xs),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        FilterPill(
                          label: 'Kecocokan Tertinggi',
                          selected: _sort == 'Kecocokan Tertinggi',
                          onTap: () =>
                              setState(() => _sort = 'Kecocokan Tertinggi'),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        FilterPill(
                          label: 'Waktu Singkat',
                          selected: _sort == 'Waktu Singkat',
                          onTap: () => setState(() => _sort = 'Waktu Singkat'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  if (visibleMatches.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppSpacing.xl,
                      ),
                      child: Text(
                        cookState.showOnlyCookable
                            ? 'Belum ada resep yang lengkap dari bahan pilihanmu.'
                            : 'Belum ada resep yang cocok.',
                        textAlign: TextAlign.center,
                        style: AppTypography.body.copyWith(
                          color: AppColors.onSurfaceVariant,
                        ),
                      ),
                    )
                  else
                    for (final match in visibleMatches) ...[
                      MatchResultRow(
                        title: match.recipe.name,
                        missing: match.missingKeys,
                        matchPercent: match.matchPercentage,
                        imageUrl: match.recipe.imageUrl,
                        onTap: () => Navigator.of(context).pushNamed(
                          RecipeDetailPage.route,
                          arguments: match.recipe,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                    ],
                ],
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Center(child: Text('Error: $error')),
            ),
          ),
        ),
      ),
    );
  }
}
