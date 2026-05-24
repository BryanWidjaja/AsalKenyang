import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radii.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/spending_history_row.dart';
import '../../../shared/widgets/top_bar.dart';

class _Entry {
  const _Entry(
    this.title,
    this.subtitle,
    this.amount,
    this.icon, {
    this.iconBackground = AppColors.surfaceContainerHighest,
    this.iconColor = AppColors.onSurfaceVariant,
  });

  final String title;
  final String subtitle;
  final String amount;
  final IconData icon;
  final Color iconBackground;
  final Color iconColor;
}

const _entries = <_Entry>[
  _Entry(
    'Belanja Sayur Lodeh',
    '24 Okt 2023 • Pasar Tradisional',
    '- Rp 25.000',
    Icons.shopping_basket_rounded,
    iconBackground: AppColors.kunyitContainer,
    iconColor: AppColors.primary,
  ),
  _Entry(
    'Minyak Goreng 1L',
    '22 Okt 2023 • Warung Pak Kumis',
    '- Rp 16.500',
    Icons.local_mall_rounded,
  ),
  _Entry(
    'Bumbu Dapur (Bawang, Cabe)',
    '20 Okt 2023 • Tukang Sayur Keliling',
    '- Rp 12.000',
    Icons.eco_rounded,
    iconBackground: AppColors.pandanContainer,
    iconColor: AppColors.secondary,
  ),
  _Entry(
    'Bahan Nasi Goreng Gila',
    '15 Okt 2023 • Supermarket Mini',
    '- Rp 45.000',
    Icons.restaurant_menu_rounded,
    iconBackground: AppColors.kunyitContainer,
    iconColor: AppColors.primary,
  ),
];

class SpendingHistoryPage extends StatelessWidget {
  const SpendingHistoryPage({super.key});

  static const String route = '/spending-history';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.riceWhite,
      appBar: const TopBar.nested(title: 'Riwayat Belanja'),
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
                Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceVariant,
                    borderRadius: AppRadii.brMd,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'TOTAL PENGELUARAN BULAN INI',
                        style: AppTypography.overline.copyWith(
                          color: AppColors.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        '- Rp 345.500',
                        style: AppTypography.budgetHero.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                Text('Riwayat Belanja', style: AppTypography.titleMd),
                const SizedBox(height: AppSpacing.md),
                for (var i = 0; i < _entries.length; i++) ...[
                  SpendingHistoryRow(
                    title: _entries[i].title,
                    subtitle: _entries[i].subtitle,
                    amount: _entries[i].amount,
                    icon: _entries[i].icon,
                    iconBackground: _entries[i].iconBackground,
                    iconColor: _entries[i].iconColor,
                  ),
                  if (i != _entries.length - 1)
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
