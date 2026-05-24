import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../shared/widgets/filter_pill.dart';
import '../../../shared/widgets/recipe_card.dart';
import '../../../shared/widgets/round_icon_button.dart';
import '../../../shared/widgets/top_bar.dart';
import 'recipe_detail_page.dart';

const _segments = ['Semua', 'Sarapan', 'Makan Siang', 'Makan Malam', 'Cemilan'];

class _Saved {
  const _Saved(this.title, this.price, this.state, this.time);
  final String title;
  final String price;
  final PriceState state;
  final String time;
}

const _saved = <_Saved>[
  _Saved('Nasi Goreng Spesial Tanggal Tua', 'Rp 12.000', PriceState.affordable, '15m'),
  _Saved('Mie Tek Tek Ala Abang-abang', 'Rp 8.500', PriceState.affordable, '10m'),
  _Saved('Sayur Sop Bening Segar', 'Rp 15.000', PriceState.mid, '25m'),
  _Saved('Telur Dadar Crispy Warteg', 'Rp 5.000', PriceState.affordable, '5m'),
];

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  static const String route = '/favorites';

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  String _segment = 'Semua';
  final Set<String> _favorited = _saved.map((s) => s.title).toSet();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.riceWhite,
      appBar: TopBar.nested(
        title: 'Resep Tersimpan',
        trailing: RoundIconButton(
          icon: Icons.search_rounded,
          color: AppColors.onSurfaceVariant,
          onPressed: () {},
        ),
      ),
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
                const SizedBox(height: AppSpacing.lg),
                _SavedGrid(
                  saved: _saved,
                  favorited: _favorited,
                  onToggle: (title) => setState(() {
                    if (!_favorited.add(title)) _favorited.remove(title);
                  }),
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
  const _SavedGrid({
    required this.saved,
    required this.favorited,
    required this.onToggle,
  });

  final List<_Saved> saved;
  final Set<String> favorited;
  final ValueChanged<String> onToggle;

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
            for (final s in saved)
              SizedBox(
                width: colWidth,
                child: RecipeCard.compact(
                  title: s.title,
                  priceText: s.price,
                  priceState: s.state,
                  timeText: s.time,
                  favorite: favorited.contains(s.title),
                  onFavoriteToggle: () => onToggle(s.title),
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
