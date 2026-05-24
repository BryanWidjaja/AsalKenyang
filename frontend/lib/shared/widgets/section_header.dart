import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import 'text_link.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
    this.icon,
    this.actionLabel,
    this.onAction,
  });

  final String title;
  final IconData? icon;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final titleStyle = icon != null
        ? AppTypography.label.copyWith(color: AppColors.primary)
        : AppTypography.titleMd;

    return Row(
      children: [
        if (icon != null) ...[
          Icon(icon, size: 18, color: AppColors.primary),
          const SizedBox(width: AppSpacing.sm),
        ],
        Expanded(child: Text(title, style: titleStyle)),
        if (actionLabel != null)
          TextLink(text: actionLabel!, onTap: onAction),
      ],
    );
  }
}
