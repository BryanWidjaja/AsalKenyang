import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/budget_hero_card.dart';
import '../../../shared/widgets/profile_header_card.dart';
import '../../../shared/widgets/section_header.dart';
import '../../../shared/widgets/settings_tile.dart';
import '../../../shared/widgets/spending_history_row.dart';
import '../../../shared/widgets/top_bar.dart';
import '../../auth/application/auth_controller.dart';
import '../../auth/presentation/login_page.dart';
import '../../recipes/presentation/favorites_page.dart';
import 'about_page.dart';
import 'spending_history_page.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.riceWhite,
      appBar: const TopBar.shell(budgetText: 'Rp 125.000'),
      body: SafeArea(
        top: false,
        child: Center(
          child: ConstrainedBox(
            constraints:
                const BoxConstraints(maxWidth: AppSpacing.screenMaxWidth),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.edge,
                AppSpacing.lg,
                AppSpacing.edge,
                AppSpacing.xl,
              ),
              children: [
                const ProfileHeaderCard(
                  name: 'Budi Santoso',
                  role: 'Mahasiswa Kost',
                ),
                const SizedBox(height: AppSpacing.lg),
                BudgetHeroCard(
                  sisaText: 'Rp 125.000',
                  terpakaiText: 'Rp 375.000',
                  totalText: 'Rp 500.000',
                  remainingPercent: 0.25,
                  remainingLabel: '25% Tersisa',
                  onAturAnggaran: () {},
                ),
                const SizedBox(height: AppSpacing.lg),
                const SectionHeader(title: 'Pengaturan'),
                const SizedBox(height: AppSpacing.md),
                _SettingsGrid(
                  onResepDisukai: () =>
                      Navigator.of(context).pushNamed(FavoritesPage.route),
                ),
                const SizedBox(height: AppSpacing.lg),
                SectionHeader(
                  title: 'Riwayat Belanja',
                  actionLabel: 'Lihat Semua',
                  onAction: () => Navigator.of(context)
                      .pushNamed(SpendingHistoryPage.route),
                ),
                const SizedBox(height: AppSpacing.md),
                const SpendingHistoryRow(
                  title: 'Pasar Tradisional',
                  subtitle: '24 Okt 2023',
                  amount: '- Rp 45.000',
                  icon: Icons.shopping_basket_rounded,
                  iconBackground: AppColors.kunyitContainer,
                  iconColor: AppColors.primary,
                ),
                const SizedBox(height: AppSpacing.md),
                const SpendingHistoryRow(
                  title: 'Minimarket',
                  subtitle: '22 Okt 2023',
                  amount: '- Rp 12.500',
                  icon: Icons.local_convenience_store_rounded,
                ),
                const SizedBox(height: AppSpacing.lg),
                TextButton(
                  onPressed: () async {
                    await ref.read(authControllerProvider.notifier).logout();
                    if (!context.mounted) return;
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      LoginPage.route,
                      (_) => false,
                    );
                  },
                  child: Text(
                    'Keluar',
                    style: AppTypography.label.copyWith(color: AppColors.error),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SettingsGrid extends StatelessWidget {
  const _SettingsGrid({required this.onResepDisukai});

  final VoidCallback onResepDisukai;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const gap = AppSpacing.sm;
        final colWidth = (constraints.maxWidth - gap) / 2;
        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: [
            SizedBox(
              width: colWidth,
              child: SettingsTile(
                icon: Icons.favorite_rounded,
                label: 'Resep Disukai',
                onTap: onResepDisukai,
              ),
            ),
            SizedBox(
              width: colWidth,
              child: SettingsTile(
                icon: Icons.kitchen_rounded,
                label: 'Bahan Tersimpan',
                onTap: () {},
              ),
            ),
            SizedBox(
              width: colWidth,
              child: SettingsTile(
                icon: Icons.notifications_rounded,
                label: 'Notifikasi',
                onTap: () {},
              ),
            ),
            SizedBox(
              width: colWidth,
              child: SettingsTile(
                icon: Icons.help_rounded,
                label: 'Bantuan',
                onTap: () => Navigator.of(context).pushNamed(AboutPage.route),
              ),
            ),
          ],
        );
      },
    );
  }
}
