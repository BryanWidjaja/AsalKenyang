import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/filter_pill.dart';
import '../../../shared/widgets/recipe_card.dart';
import '../../../shared/widgets/round_icon_button.dart';
import '../../../shared/widgets/search_field.dart';
import '../../../shared/widgets/top_bar.dart';
import '../../budget/application/budget_controller.dart';
import '../application/recipe_providers.dart';
import '../application/favorites_controller.dart';
import '../data/recipe_models.dart';
import 'favorites_page.dart';
import 'recipe_detail_page.dart';
import '../../plan/application/plan_controller.dart';

class _Filter {
  const _Filter(this.label, this.icon);
  final String label;
  final IconData? icon;
}

const _filters = <_Filter>[
  _Filter('Semua', null),
  _Filter('Rice Cooker Aja', Icons.rice_bowl_rounded),
  _Filter('Tanpa Kompor', Icons.kitchen_rounded),
  _Filter('<Rp 10rb', Icons.payments_rounded),
  _Filter('Kilat', Icons.timer_rounded),
];

class RecipeBrowsePage extends ConsumerWidget {
  const RecipeBrowsePage({super.key});

  static const String route = '/recipe-browse';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final args = ModalRoute.of(context)?.settings.arguments;
    final selectForDate = args is DateTime ? args : null;

    final filter = ref.watch(recipeFilterProvider);
    final recipesAsync = ref.watch(filteredRecipesProvider);
    final budgetState = ref.watch(budgetControllerProvider);
    final fmt = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return Scaffold(
      backgroundColor: AppColors.riceWhite,
      appBar: selectForDate != null
          ? const TopBar.nested(title: 'Pilih Resep')
          : TopBar.shell(budgetText: fmt.format(budgetState.remainingBudget)),
      body: SafeArea(
        top: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: AppSpacing.screenMaxWidth,
            ),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.edge,
                AppSpacing.md,
                AppSpacing.edge,
                AppSpacing.xl,
              ),
              children: [
                Row(
                  children: [
                    Expanded(
                      child: SearchField(
                        onChanged: (val) => ref
                            .read(recipeSearchQueryProvider.notifier)
                            .updateState(val),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    RoundIconButton(
                      icon: Icons.favorite_border_rounded,
                      color: AppColors.primary,
                      tooltip: 'Resep tersimpan',
                      onPressed: () =>
                          Navigator.of(context).pushNamed(FavoritesPage.route),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (final f in _filters) ...[
                        FilterPill(
                          label: f.label,
                          icon: f.icon,
                          selected: filter == f.label,
                          onTap: () => ref
                              .read(recipeFilterProvider.notifier)
                              .updateState(f.label),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                RecipeCard.feature(
                  title: 'Nasi Goreng Kosan',
                  priceText: 'Rp 5.440/porsi',
                  priceState: _priceStateFor(5440, budgetState.remainingBudget),
                  timeText: '10 mnt',
                  equipmentIcon: Icons.soup_kitchen_rounded,
                  dotsFilled: 2,
                  onTap: () async {
                    if (selectForDate != null) {
                      final waktu = await _showWaktuMakanSheet(context);
                      if (waktu == null) return;
                      try {
                        await ref
                            .read(planControllerProvider)
                            .addMeal(selectForDate, 'mock_01', waktu);
                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Berhasil menambahkan ke rencana!'),
                          ),
                        );
                        Navigator.of(context).pop();
                      } catch (error) {
                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Gagal menambahkan ke rencana: $error',
                            ),
                          ),
                        );
                      }
                    } else {
                      Navigator.of(
                        context,
                      ).pushNamed(RecipeDetailPage.route, arguments: 'mock_01');
                    }
                  },
                ),
                const SizedBox(height: AppSpacing.md),
                recipesAsync.when(
                  data: (recipes) => _RecipeGrid(
                    recipes: recipes,
                    selectForDate: selectForDate,
                    remainingBudget: budgetState.remainingBudget,
                  ),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (e, _) => Center(child: Text('Error: $e')),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RecipeGrid extends ConsumerWidget {
  const _RecipeGrid({
    required this.recipes,
    required this.remainingBudget,
    this.selectForDate,
  });

  final List<Recipe> recipes;
  final int remainingBudget;
  final DateTime? selectForDate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesControllerProvider).value ?? [];
    final favoriteIds = favorites.map((favorite) => favorite.recipeId).toSet();
    final fmt = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        const gap = AppSpacing.md;
        final colWidth = (constraints.maxWidth - gap) / 2;
        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: [
            for (final r in recipes)
              SizedBox(
                width: colWidth,
                child: RecipeCard.compact(
                  title: r.name,
                  priceText: '${fmt.format(_perServingPrice(r)).trim()}/porsi',
                  priceState: _priceStateFor(r.estPrice, remainingBudget),
                  timeText: '${r.cookTime} mnt',
                  pedas: r.tags.contains('pedas'),
                  favorite: favoriteIds.contains(r.id),
                  onFavoriteToggle: () => ref
                      .read(favoritesControllerProvider.notifier)
                      .toggleFavorite(r.id),
                  onTap: () async {
                    if (selectForDate != null) {
                      final waktu = await _showWaktuMakanSheet(context);
                      if (waktu == null) return;
                      try {
                        await ref
                            .read(planControllerProvider)
                            .addMeal(selectForDate!, r.id, waktu);
                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Berhasil menambahkan ke rencana!'),
                          ),
                        );
                        Navigator.of(context).pop();
                      } catch (error) {
                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Gagal menambahkan ke rencana: $error',
                            ),
                          ),
                        );
                      }
                    } else {
                      Navigator.of(
                        context,
                      ).pushNamed(RecipeDetailPage.route, arguments: r.id);
                    }
                  },
                ),
              ),
          ],
        );
      },
    );
  }
}

PriceState _priceStateFor(int price, int remainingBudget) {
  if (remainingBudget <= 0 || price <= remainingBudget) {
    return PriceState.affordable;
  }
  if (price <= remainingBudget * 1.2) return PriceState.mid;
  return PriceState.unaffordable;
}

int _perServingPrice(Recipe recipe) {
  if (recipe.porsi <= 0) return recipe.estPrice;
  return (recipe.estPrice / recipe.porsi).round();
}

Future<String?> _showWaktuMakanSheet(BuildContext context) {
  return showModalBottomSheet<String>(
    context: context,
    backgroundColor: AppColors.surfaceContainerLowest,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Pilih Waktu Makan', style: AppTypography.h3),
            const SizedBox(height: AppSpacing.md),
            ListTile(
              title: const Text('Pagi', style: AppTypography.bodyLg),
              onTap: () => Navigator.of(context).pop('pagi'),
            ),
            ListTile(
              title: const Text('Siang', style: AppTypography.bodyLg),
              onTap: () => Navigator.of(context).pop('siang'),
            ),
            ListTile(
              title: const Text('Sore', style: AppTypography.bodyLg),
              onTap: () => Navigator.of(context).pop('sore'),
            ),
            ListTile(
              title: const Text('Malam', style: AppTypography.bodyLg),
              onTap: () => Navigator.of(context).pop('malam'),
            ),
            const SizedBox(height: AppSpacing.md),
          ],
        ),
      );
    },
  );
}
