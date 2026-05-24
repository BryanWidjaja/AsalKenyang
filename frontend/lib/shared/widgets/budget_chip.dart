import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radii.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';

class BudgetChip extends StatelessWidget {
  const BudgetChip({super.key, required this.amount, this.onTap});

  final String amount;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surfaceContainerLow,
      borderRadius: AppRadii.brFull,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadii.brFull,
        child: Container(
          height: 32,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          alignment: Alignment.center,
          child: Text(
            amount,
            style: AppTypography.label.copyWith(
              color: AppColors.primary,
              fontFeatures: AppTypography.tnum,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
