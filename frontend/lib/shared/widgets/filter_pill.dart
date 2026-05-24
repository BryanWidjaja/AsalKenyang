import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radii.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';

class FilterPill extends StatelessWidget {
  const FilterPill({
    super.key,
    required this.label,
    required this.selected,
    this.icon,
    this.onTap,
  });

  final String label;
  final IconData? icon;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final fill = selected
        ? AppColors.terracottaContainer
        : AppColors.surfaceContainerLowest;
    final foreground = selected
        ? AppColors.onPrimaryFixedVariant
        : AppColors.onSurfaceVariant;
    final border = selected
        ? Border.all(color: Colors.transparent)
        : Border.all(color: AppColors.outlineVariant);

    return Material(
      color: fill,
      borderRadius: AppRadii.brFull,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadii.brFull,
        child: Container(
          height: 32,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          decoration: BoxDecoration(
            border: border,
            borderRadius: AppRadii.brFull,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 16, color: foreground),
                const SizedBox(width: AppSpacing.xs),
              ],
              Text(
                label,
                style: AppTypography.label.copyWith(color: foreground),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
