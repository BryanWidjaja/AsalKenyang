import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radii.dart';
import '../../core/theme/app_typography.dart';

class TagPill extends StatelessWidget {
  const TagPill({
    super.key,
    required this.label,
    this.background = AppColors.kunyitContainer,
    this.foreground = AppColors.onTertiaryFixed,
  });

  const TagPill.pedas({super.key, this.label = 'PEDAS'})
      : background = AppColors.pedasTag,
        foreground = AppColors.onPrimaryFixedVariant;

  const TagPill.murah({super.key, this.label = 'MURAH'})
      : background = AppColors.kunyitContainer,
        foreground = AppColors.onTertiaryFixed;

  const TagPill.cepat({super.key, this.label = 'CEPAT'})
      : background = AppColors.kunyitContainer,
        foreground = AppColors.onTertiaryFixed;

  final String label;
  final Color background;
  final Color foreground;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: background,
        borderRadius: AppRadii.brFull,
      ),
      child: Text(
        label,
        style: AppTypography.overline.copyWith(color: foreground),
      ),
    );
  }
}
