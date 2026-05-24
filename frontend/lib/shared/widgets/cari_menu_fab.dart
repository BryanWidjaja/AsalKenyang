import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radii.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';

class CariMenuFab extends StatelessWidget {
  const CariMenuFab({
    super.key,
    required this.label,
    this.icon = Icons.search_rounded,
    this.onPressed,
    this.badgeCount,
  });

  final String label;
  final IconData icon;
  final VoidCallback? onPressed;
  final int? badgeCount;

  @override
  Widget build(BuildContext context) {
    final text = badgeCount != null ? '$label ($badgeCount)' : label;
    return Material(
      color: AppColors.terracottaContainer,
      borderRadius: AppRadii.brFull,
      elevation: 4,
      shadowColor: AppColors.warmCharcoal.withValues(alpha: 0.2),
      child: InkWell(
        onTap: onPressed,
        borderRadius: AppRadii.brFull,
        child: Container(
          height: 56,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 22, color: AppColors.warmCharcoal),
              const SizedBox(width: AppSpacing.sm),
              Text(
                text,
                style: AppTypography.label.copyWith(
                  color: AppColors.warmCharcoal,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
