import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radii.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    this.icon,
    this.onPressed,
    this.fullWidth = true,
  });

  final String label;
  final IconData? icon;
  final VoidCallback? onPressed;
  final bool fullWidth;

  @override
  Widget build(BuildContext context) {
    final disabled = onPressed == null;
    final fill = disabled
        ? AppColors.primary.withValues(alpha: 0.38)
        : AppColors.primary;
    final foreground = disabled
        ? AppColors.onPrimary.withValues(alpha: 0.7)
        : AppColors.onPrimary;

    final button = Material(
      color: fill,
      borderRadius: AppRadii.brMd,
      child: InkWell(
        onTap: onPressed,
        borderRadius: AppRadii.brMd,
        child: SizedBox(
          height: AppSpacing.touchTarget,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.edge),
            child: Row(
              mainAxisSize: fullWidth ? MainAxisSize.max : MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) ...[
                  Icon(icon, size: 20, color: foreground),
                  const SizedBox(width: AppSpacing.sm),
                ],
                Text(
                  label,
                  style: AppTypography.label.copyWith(color: foreground),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    return fullWidth ? SizedBox(width: double.infinity, child: button) : button;
  }
}
