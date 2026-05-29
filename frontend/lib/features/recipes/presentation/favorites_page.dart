import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../shared/widgets/filter_pill.dart';
import '../../../shared/widgets/recipe_card.dart';
import '../../../shared/widgets/round_icon_button.dart';
import '../../../shared/widgets/search_field.dart';
import '../../../shared/widgets/top_bar.dart';
import '../application/recipe_providers.dart';
import '../application/favorites_controller.dart';
import '../data/recipe_models.dart';
import 'recipe_detail_page.dart';

const _segments = ['Semua', 'Sarapan', 'Makan Siang', 'Makan Malam', 'Cemilan'];

class FavoritesPage extends ConsumerStatefulWidget {
  const FavoritesPage({super.key});

  static const String route = '/favorites';

  @override
  ConsumerState<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends ConsumerState<FavoritesPage> {
  String _segment = 'Semua';
  String _query = '';
  bool _showSearch = false;

  @override
  Widget build(BuildContext context) {
    final favoritesAsync = ref.watch(favoritedRecipesProvider);

    return Scaffold(
      backgroundColor: AppColors.riceWhite,
      appBar: TopBar.nested(
        title: 'Resep Tersimpan',
        trailing: RoundIconButton(
          icon: Icons.search_rounded,
          color: AppColors.onSurfaceVariant,
          onPressed: () => setState(() => _showSearch = !_showSearch),
        ),
      ),
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
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (final s in _segments) ...[
                        FilterPill(
                          label: s,
                          selected: _segment == s,
                          onTap: () => setState(() => _segment = s),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                      ],
                    ],
                  ),
                ),
                if (_showSearch) ...[
                  const SizedBox(height: AppSpacing.md),
                  SearchField(
                    onChanged: (value) => setState(() => _query = value),
                  ),
                ],
                const SizedBox(height: AppSpacing.lg),
                favoritesAsync.when(
                  data: (recipes) {
                    final visible = recipes.where((r) {
                      final matchesSegment =
                          _segment == 'Semua' ||
                          r.tags.contains(_segment.toLowerCase());
                      final matchesQuery =
                          _query.trim().isEmpty ||
                          r.name.toLowerCase().contains(_query.toLowerCase());
                      return matchesSegment && matchesQuery;
                    }).toList();

                    if (visible.isEmpty) {
                      return const Center(
                        child: Text('Belum ada resep tersimpan'),
                      );
                    }

                    return _SavedGrid(
                      saved: visible,
                      onToggle: (id) => ref
                          .read(favoritesControllerProvider.notifier)
                          .toggleFavorite(id),
                    );
                  },
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

class _SavedGrid extends StatelessWidget {
  const _SavedGrid({required this.saved, required this.onToggle});

  final List<Recipe> saved;
  final ValueChanged<String> onToggle;

  @override
  Widget build(BuildContext context) {
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
            for (final r in saved)
              SizedBox(
                width: colWidth,
                child: RecipeCard.compact(
                  title: r.name,
                  priceText: '${fmt.format(_perServingPrice(r)).trim()}/porsi',
                  priceState: PriceState.affordable,
                  timeText: '${r.cookTime} mnt',
                  favorite: true,
                  pedas: r.tags.contains('pedas'),
                  onFavoriteToggle: () => onToggle(r.id),
                  onTap: () => Navigator.of(
                    context,
                  ).pushNamed(RecipeDetailPage.route, arguments: r.id),
                ),
              ),
          ],
        );
      },
    );
  }
}

int _perServingPrice(Recipe recipe) {
  if (recipe.porsi <= 0) return recipe.estPrice;
  return (recipe.estPrice / recipe.porsi).round();
}
