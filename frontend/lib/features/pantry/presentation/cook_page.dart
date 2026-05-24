import 'package:flutter/material.dart';

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
import '../../recipes/presentation/search_results_page.dart';

class _Ingredient {
  const _Ingredient(this.label, this.icon, this.category);
  final String label;
  final IconData icon;
  final String category;
}

const _categories = ['Semua', 'Protein', 'Sayur', 'Bumbu', 'Karbohidrat'];

const _ingredients = <_Ingredient>[
  _Ingredient('Telur', Icons.egg_rounded, 'Protein'),
  _Ingredient('Ikan', Icons.set_meal_rounded, 'Protein'),
  _Ingredient('Ayam', Icons.kebab_dining_rounded, 'Protein'),
  _Ingredient('Tahu', Icons.lunch_dining_rounded, 'Protein'),
  _Ingredient('Tempe', Icons.bakery_dining_rounded, 'Protein'),
  _Ingredient('Sawi', Icons.eco_rounded, 'Sayur'),
  _Ingredient('Wortel', Icons.local_florist_rounded, 'Sayur'),
  _Ingredient('Tomat', Icons.circle_rounded, 'Sayur'),
  _Ingredient('Bawang', Icons.grass_rounded, 'Bumbu'),
  _Ingredient('Cabai', Icons.local_fire_department_rounded, 'Bumbu'),
  _Ingredient('Kecap', Icons.water_drop_rounded, 'Bumbu'),
  _Ingredient('Nasi', Icons.rice_bowl_rounded, 'Karbohidrat'),
  _Ingredient('Mie', Icons.ramen_dining_rounded, 'Karbohidrat'),
  _Ingredient('Roti', Icons.cookie_rounded, 'Karbohidrat'),
];

class CookPage extends StatefulWidget {
  const CookPage({super.key});

  @override
  State<CookPage> createState() => _CookPageState();
}

class _CookPageState extends State<CookPage> {
  String _category = 'Semua';
  bool _budgetCapEnabled = true;
  final Set<String> _selected = {'Telur', 'Ayam', 'Bawang'};

  List<_Ingredient> get _visible {
    if (_category == 'Semua') return _ingredients;
    return _ingredients.where((i) => i.category == _category).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.riceWhite,
      appBar: const TopBar.shell(budgetText: 'Rp 47.000'),
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
                  value: _budgetCapEnabled,
                  onChanged: (v) => setState(() => _budgetCapEnabled = v),
                ),
                const SizedBox(height: AppSpacing.lg),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (final c in _categories) ...[
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
                  selected: _selected,
                  onToggle: (label) => setState(() {
                    if (!_selected.add(label)) _selected.remove(label);
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: _selected.isEmpty
        ? null
        : CariMenuFab(
            label: 'Cari Menu',
            badgeCount: _selected.length,
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
                Text('Atur Uang Tersedia', style: AppTypography.titleMd),
                const SizedBox(height: 2),
                Text(
                  'Sesuaikan budget masak hari ini',
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

  final List<_Ingredient> ingredients;
  final Set<String> selected;
  final ValueChanged<String> onToggle;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const columns = 4;
        const gap = AppSpacing.md;
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
                  selected: selected.contains(ing.label),
                  onTap: () => onToggle(ing.label),
                ),
              ),
          ],
        );
      },
    );
  }
}
