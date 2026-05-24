import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../shared/widgets/filter_pill.dart';
import '../../../shared/widgets/recipe_card.dart';
import '../../../shared/widgets/round_icon_button.dart';
import '../../../shared/widgets/search_field.dart';
import '../../../shared/widgets/top_bar.dart';
import 'favorites_page.dart';
import 'recipe_detail_page.dart';

class _Filter {
  const _Filter(this.label, this.icon);
  final String label;
  final IconData? icon;
}

const _filters = <_Filter>[
  _Filter('Semua', null),
  _Filter('Rice Cooker', Icons.rice_bowl_rounded),
  _Filter('Tanpa Kompor', Icons.kitchen_rounded),
  _Filter('< Rp 10rb', Icons.savings_rounded),
  _Filter('Kilat (10mnt)', Icons.schedule_rounded),
];

class _Recipe {
  const _Recipe(this.title, this.price, this.state, this.time, {this.pedas = false});
  final String title;
  final String price;
  final PriceState state;
  final String time;
  final bool pedas;
}

const _recipes = <_Recipe>[
  _Recipe('Mie Tek Tek Kuah', 'Rp 8.000/porsi', PriceState.mid, '15m'),
  _Recipe('Tumis Sarden Pedas', 'Rp 12.000/porsi', PriceState.unaffordable, '12m',
      pedas: true),
  _Recipe('Telur Dadar Warteg', 'Rp 5.000/porsi', PriceState.affordable, '5m'),
  _Recipe('Sayur Sop Bening', 'Rp 9.500/porsi', PriceState.mid, '25m'),
  _Recipe('Tempe Orek Kecap', 'Rp 7.000/porsi', PriceState.affordable, '10m'),
  _Recipe('Ayam Goreng Sambal', 'Rp 15.000/porsi', PriceState.unaffordable, '30m',
      pedas: true),
];

class RecipeBrowsePage extends StatefulWidget {
  const RecipeBrowsePage({super.key});

  @override
  State<RecipeBrowsePage> createState() => _RecipeBrowsePageState();
}

class _RecipeBrowsePageState extends State<RecipeBrowsePage> {
  String _filter = 'Semua';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.riceWhite,
      appBar: const TopBar.shell(budgetText: 'Rp 47.000'),
      body: SafeArea(
        top: false,
        child: Center(
          child: ConstrainedBox(
            constraints:
                const BoxConstraints(maxWidth: AppSpacing.screenMaxWidth),
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
                    const Expanded(child: SearchField()),
                    const SizedBox(width: AppSpacing.sm),
                    RoundIconButton(
                      icon: Icons.favorite_border_rounded,
                      color: AppColors.primary,
                      tooltip: 'Resep tersimpan',
                      onPressed: () => Navigator.of(context)
                          .pushNamed(FavoritesPage.route),
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
                          selected: _filter == f.label,
                          onTap: () => setState(() => _filter = f.label),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                RecipeCard.feature(
                  title: 'Nasi Telur Pontianak',
                  priceText: 'Rp 5.500/porsi',
                  priceState: PriceState.affordable,
                  timeText: '10 mnt',
                  equipmentIcon: Icons.soup_kitchen_rounded,
                  dotsFilled: 2,
                  onTap: () =>
                      Navigator.of(context).pushNamed(RecipeDetailPage.route),
                ),
                const SizedBox(height: AppSpacing.md),
                _RecipeGrid(recipes: _recipes),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RecipeGrid extends StatelessWidget {
  const _RecipeGrid({required this.recipes});

  final List<_Recipe> recipes;

  @override
  Widget build(BuildContext context) {
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
                  title: r.title,
                  priceText: r.price,
                  priceState: r.state,
                  timeText: r.time,
                  pedas: r.pedas,
                  onTap: () =>
                      Navigator.of(context).pushNamed(RecipeDetailPage.route),
                ),
              ),
          ],
        );
      },
    );
  }
}
