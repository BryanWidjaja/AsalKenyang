import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';

class RoundIconButton extends StatelessWidget {
  const RoundIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.color,
    this.tooltip,
    this.size = 24,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final Color? color;
  final String? tooltip;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppSpacing.touchTarget,
      height: AppSpacing.touchTarget,
      child: IconButton(
        onPressed: onPressed,
        tooltip: tooltip,
        iconSize: size,
        icon: Icon(icon, color: color ?? AppColors.onSurfaceVariant),
      ),
    );
  }
}
