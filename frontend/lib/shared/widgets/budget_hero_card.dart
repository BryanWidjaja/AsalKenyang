import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_elevation.dart';
import '../../core/theme/app_radii.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import 'budget_gauge.dart';
import 'primary_button.dart';

class BudgetHeroCard extends StatelessWidget {
  const BudgetHeroCard({
    super.key,
    required this.sisaText,
    required this.terpakaiText,
    required this.totalText,
    required this.remainingPercent,
    required this.remainingLabel,
    this.onAturAnggaran,
  });

  final String sisaText;
  final String terpakaiText;
  final String totalText;
  final double remainingPercent;
  final String remainingLabel;
  final VoidCallback? onAturAnggaran;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: AppRadii.brMd,
        boxShadow: AppElevation.level2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'SISA ANGGARAN BULAN INI',
            style: AppTypography.label.copyWith(
              color: AppColors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            sisaText,
            style: AppTypography.budgetHero.copyWith(color: AppColors.primary),
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Terpakai: $terpakaiText',
                  style: AppTypography.caption.copyWith(
                    fontFeatures: AppTypography.tnum,
                  ),
                ),
              ),
              Text(
                'Total: $totalText',
                style: AppTypography.caption.copyWith(
                  fontFeatures: AppTypography.tnum,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          BudgetGauge(percent: remainingPercent),
          const SizedBox(height: AppSpacing.xs),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              remainingLabel,
              style: AppTypography.caption.copyWith(color: AppColors.outline),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          PrimaryButton(label: 'Atur Anggaran', onPressed: onAturAnggaran),
        ],
      ),
    );
  }
}
