import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radii.dart';
import '../../core/theme/app_typography.dart';

class TextLink extends StatelessWidget {
  const TextLink({
    super.key,
    required this.text,
    this.onTap,
    this.color,
  });

  final String text;
  final VoidCallback? onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppRadii.brSm,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
        child: Text(
          text,
          style: AppTypography.label.copyWith(color: color ?? AppColors.primary),
        ),
      ),
    );
  }
}
