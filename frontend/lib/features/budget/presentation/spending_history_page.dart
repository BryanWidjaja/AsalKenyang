import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radii.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/spending_history_row.dart';
import '../../../shared/widgets/top_bar.dart';
import '../application/budget_controller.dart';

class SpendingHistoryPage extends ConsumerWidget {
  const SpendingHistoryPage({super.key});

  static const String route = '/spending-history';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final budgetState = ref.watch(budgetControllerProvider);
    final fmt = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

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
                        '- ${fmt.format(budgetState.totalSpendings)}',
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
                if (budgetState.spendings.isEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
                    child: Text('Belum ada riwayat belanja.', textAlign: TextAlign.center),
                  ),
                for (var index = 0; index < budgetState.spendings.length; index++) ...[
                  SpendingHistoryRow(
                    title: budgetState.spendings[index].title,
                    subtitle: DateFormat('dd MMM yyyy').format(budgetState.spendings[index].date),
                    amount: '- ${fmt.format(budgetState.spendings[index].amount)}',
                    icon: Icons.receipt_long_rounded,
                  ),
                  if (index != budgetState.spendings.length - 1)
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
