import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_elevation.dart';
import '../../core/theme/app_radii.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import 'budget_gauge.dart';

class BudgetSummaryStrip extends StatelessWidget {
  const BudgetSummaryStrip({
    super.key,
    required this.estimasiText,
    required this.sisaText,
    required this.remainingPercent,
    this.estimasiLabel = 'Estimasi Belanja',
    this.sisaLabel = 'Sisa Anggaran',
  });

  final String estimasiText;
  final String sisaText;
  final double remainingPercent;
  final String estimasiLabel;
  final String sisaLabel;

  ({Color bg, Color fg}) get _pillColors {
    if (remainingPercent > 0.5) {
      return (bg: AppColors.pandanContainer, fg: AppColors.secondary);
    }
    if (remainingPercent >= 0.2) {
      return (bg: AppColors.kunyitContainer, fg: AppColors.tertiary);
    }
    return (bg: AppColors.terracottaContainer, fg: AppColors.primary);
  }

  @override
  Widget build(BuildContext context) {
    final pill = _pillColors;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: AppRadii.brMd,
        boxShadow: AppElevation.level1,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      estimasiLabel.toUpperCase(),
                      style: AppTypography.overline.copyWith(
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      estimasiText,
                      style: AppTypography.h2.copyWith(
                        fontFeatures: AppTypography.tnum,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    sisaLabel.toUpperCase(),
                    style: AppTypography.overline.copyWith(
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: pill.bg,
                      borderRadius: AppRadii.brSm,
                    ),
                    child: Text(
                      sisaText,
                      style: AppTypography.titleMd.copyWith(
                        color: pill.fg,
                        fontFeatures: AppTypography.tnum,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          BudgetGauge(percent: remainingPercent),
        ],
      ),
    );
  }
}
