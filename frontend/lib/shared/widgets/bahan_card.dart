import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_elevation.dart';
import '../../core/theme/app_radii.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import 'budget_gauge.dart';

class BahanCard extends StatelessWidget {
  const BahanCard({
    super.key,
    required this.name,
    required this.amount,
    required this.price,
    required this.icon,
  })  : _wide = false,
        gaugePercent = null;

  const BahanCard.wide({
    super.key,
    required this.name,
    required this.amount,
    required this.price,
    required this.icon,
    this.gaugePercent = 1.0,
  }) : _wide = true;

  final bool _wide;
  final String name;
  final String amount;
  final String price;
  final IconData icon;
  final double? gaugePercent;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: _wide ? 2 / 1 : 1,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLowest,
          borderRadius: AppRadii.brMd,
          boxShadow: AppElevation.level1,
          border: Border.all(
            color: AppColors.outlineVariant.withValues(alpha: 0.3),
          ),
        ),
        child: _wide ? _wideBody() : _squareBody(),
      ),
    );
  }

  Widget _iconCircle(double size) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        color: AppColors.surfaceContainer,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Icon(icon, size: size * 0.55, color: AppColors.primary),
    );
  }

  Widget _squareBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _iconCircle(40),
            const Spacer(),
            Text(
              amount,
              style: AppTypography.label.copyWith(
                color: AppColors.onSurfaceVariant,
                fontFeatures: AppTypography.tnum,
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              name,
              style: AppTypography.label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              price,
              style: AppTypography.caption.copyWith(
                fontFeatures: AppTypography.tnum,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _wideBody() {
    return Row(
      children: [
        _iconCircle(48),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                name,
                style: AppTypography.label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                '$amount • $price',
                style: AppTypography.caption.copyWith(
                  fontFeatures: AppTypography.tnum,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        SizedBox(
          width: 64,
          child: BudgetGauge(percent: gaugePercent ?? 1.0, animate: false),
        ),
      ],
    );
  }
}
