import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/filter_pill.dart';
import '../../../shared/widgets/match_result_row.dart';
import '../../../shared/widgets/top_bar.dart';

class _Result {
  const _Result(this.title, this.missing, this.match);
  final String title;
  final List<String> missing;
  final double match;
}

const _results = <_Result>[
  _Result('Nasi Goreng Telur Sosis', ['Kecap Manis'], 0.9),
  _Result('Telur Dadar Daun Bawang', ['Daun Bawang', 'Garam'], 0.75),
  _Result('Tumis Tahu Kecap', ['Kecap Manis', 'Bawang Putih'], 0.7),
  _Result('Soto Ayam Kuning Sedap', ['Ayam', 'Kunyit', 'Santan', 'Serai'], 0.4),
  _Result('Sayur Sop Bening', ['Wortel', 'Kentang', 'Buncis'], 0.35),
];

class SearchResultsPage extends StatefulWidget {
  const SearchResultsPage({super.key});

  static const String route = '/search-results';

  @override
  State<SearchResultsPage> createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage> {
  String _sort = 'Kecocokan Tertinggi';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.riceWhite,
      appBar: const TopBar.nested(title: 'Resep'),
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
                Text(
                  'Ditemukan ${_results.length} resep',
                  style: AppTypography.titleMd,
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'Berdasarkan bahan di kulkasmu.',
                  style: AppTypography.body.copyWith(
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      FilterPill(
                        label: 'Filter',
                        icon: Icons.tune_rounded,
                        selected: false,
                        onTap: () {},
                      ),
                      const SizedBox(width: AppSpacing.sm),
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
                for (final r in _results) ...[
                  MatchResultRow(
                    title: r.title,
                    missing: r.missing,
                    matchPercent: r.match,
                    onTap: () {},
                  ),
                  const SizedBox(height: AppSpacing.md),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
