import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_elevation.dart';
import '../../core/theme/app_radii.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';

class DayPlanCard extends StatelessWidget {
  const DayPlanCard({
    super.key,
    required this.day,
    required this.date,
    this.recipes = const [],
    this.onAdd,
    this.dimmed = false,
  });

  final String day;
  final String date;
  final List<Widget> recipes;
  final VoidCallback? onAdd;
  final bool dimmed;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: dimmed ? 0.75 : 1,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLowest,
          borderRadius: AppRadii.brMd,
          boxShadow: AppElevation.level1,
          border: Border.all(color: AppColors.surfaceContainerHigh),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(child: Text(day, style: AppTypography.titleMd)),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: AppSpacing.xs,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerLow,
                    borderRadius: AppRadii.brSm,
                  ),
                  child: Text(
                    date,
                    style: AppTypography.caption.copyWith(
                      fontFeatures: AppTypography.tnum,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            if (recipes.isEmpty)
              _AddSlot(label: 'Pilih resep', onAdd: onAdd)
            else ...[
              for (var i = 0; i < recipes.length; i++) ...[
                recipes[i],
                const SizedBox(height: AppSpacing.sm),
              ],
              _AddSlot(label: 'Tambah resep', onAdd: onAdd),
            ],
          ],
        ),
      ),
    );
  }
}

class _AddSlot extends StatelessWidget {
  const _AddSlot({required this.label, this.onAdd});

  final String label;
  final VoidCallback? onAdd;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surfaceContainer,
      borderRadius: AppRadii.brSm,
      child: InkWell(
        onTap: onAdd,
        borderRadius: AppRadii.brSm,
        child: Container(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.xs,
            AppSpacing.xs,
            AppSpacing.md,
            AppSpacing.xs,
          ),
          decoration: BoxDecoration(
            borderRadius: AppRadii.brSm,
            border: Border.all(
              color: AppColors.outlineVariant.withValues(alpha: 0.4),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.surfaceVariant,
                  borderRadius: AppRadii.brSm,
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.restaurant_rounded,
                  size: 20,
                  color: AppColors.outline,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Text(
                  label,
                  style: AppTypography.label.copyWith(
                    color: AppColors.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  color: AppColors.surfaceContainerHighest,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.add_rounded,
                  size: 20,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
