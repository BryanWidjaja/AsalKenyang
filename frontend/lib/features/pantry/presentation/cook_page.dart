import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_elevation.dart';
import '../../../core/theme/app_radii.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/cari_menu_fab.dart';
import '../../../shared/widgets/filter_pill.dart';
import '../../../shared/widgets/ingredient_tile.dart';
import '../../../shared/widgets/toggle_switch.dart';
import '../../../shared/widgets/top_bar.dart';
import '../../budget/application/budget_controller.dart';
import '../../recipes/application/cook_controller.dart';
import '../../recipes/presentation/search_results_page.dart';
import '../application/pantry_controller.dart';

import '../data/ingredient_catalog.dart';

class CookPage extends ConsumerStatefulWidget {
  const CookPage({super.key});

  @override
  ConsumerState<CookPage> createState() => _CookPageState();
}

class _CookPageState extends ConsumerState<CookPage> {
  String _category = 'Semua';

  List<IngredientDef> get _visible {
    if (_category == 'Semua') return ingredientCatalog;
    return ingredientCatalog.where((i) => i.category == _category).toList();
  }

  @override
  Widget build(BuildContext context) {
    final pantryState = ref.watch(pantryControllerProvider);
    final cookState = ref.watch(cookControllerProvider);
    final budgetState = ref.watch(budgetControllerProvider);

    final savedKeys = pantryState.items.map((e) => e.bahanKey).toSet();
    final selectedKeys = cookState.selectedIngredientKeys ?? savedKeys;
    final fmt = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );

    return Scaffold(
      backgroundColor: AppColors.riceWhite,
      appBar: TopBar.shell(budgetText: fmt.format(budgetState.remainingBudget)),
      body: SafeArea(
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
                AppSpacing.xl + AppSpacing.touchTarget,
              ),
              children: [
                _BudgetToggleCard(
                  value: cookState.useBudgetFilter,
                  onChanged: (v) => ref
                      .read(cookControllerProvider.notifier)
                      .toggleBudgetFilter(v),
                ),
                const SizedBox(height: AppSpacing.lg),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (final c in ingredientCategories) ...[
                        FilterPill(
                          label: c,
                          selected: _category == c,
                          onTap: () => setState(() => _category = c),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                Text('Pilih Bahan yang Ada', style: AppTypography.titleMd),
                const SizedBox(height: AppSpacing.md),
                _IngredientsGrid(
                  ingredients: _visible,
                  selected: selectedKeys,
                  onToggle: (label) => ref
                      .read(cookControllerProvider.notifier)
                      .toggleIngredient(label, savedKeys),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: selectedKeys.isEmpty
          ? null
          : CariMenuFab(
              label: 'Cari Menu',
              badgeCount: selectedKeys.length,
              onPressed: () =>
                  Navigator.of(context).pushNamed(SearchResultsPage.route),
            ),
    );
  }
}

class _BudgetToggleCard extends StatelessWidget {
  const _BudgetToggleCard({required this.value, required this.onChanged});

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: AppRadii.brMd,
        boxShadow: AppElevation.level1,
        border: Border.all(
          color: AppColors.outlineVariant.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Atur Resep Sesuai Budget', style: AppTypography.titleMd),
                const SizedBox(height: 2),
                Text(
                  'Sembunyikan resep yang melebihi sisa uang',
                  style: AppTypography.caption,
                ),
              ],
            ),
          ),
          ToggleSwitch(value: value, onChanged: onChanged),
        ],
      ),
    );
  }
}

class _IngredientsGrid extends StatelessWidget {
  const _IngredientsGrid({
    required this.ingredients,
    required this.selected,
    required this.onToggle,
  });

  final List<IngredientDef> ingredients;
  final Set<String> selected;
  final ValueChanged<String> onToggle;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const gap = AppSpacing.md;
        final columns = constraints.maxWidth < 360 ? 3 : 4;
        final tileWidth =
            (constraints.maxWidth - gap * (columns - 1)) / columns;
        return Wrap(
          spacing: gap,
          runSpacing: AppSpacing.md,
          children: [
            for (final ing in ingredients)
              SizedBox(
                width: tileWidth,
                child: IngredientTile(
                  label: ing.label,
                  icon: ing.icon,
                  selected: selected.contains(ing.key),
                  onTap: () => onToggle(ing.key),
                ),
              ),
          ],
        );
      },
    );
  }
}
