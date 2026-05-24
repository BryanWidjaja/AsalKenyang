import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radii.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';

class PlannedRecipeRow extends StatelessWidget {
  const PlannedRecipeRow({
    super.key,
    required this.title,
    required this.subtitle,
    this.imageUrl,
    this.onTap,
  });

  final String title;
  final String subtitle;
  final String? imageUrl;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surfaceContainer,
      borderRadius: AppRadii.brSm,
      child: InkWell(
        onTap: onTap,
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
              color: AppColors.outlineVariant.withValues(alpha: 0.3),
            ),
          ),
          child: Row(
            children: [
              _thumb(),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: AppTypography.label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: AppTypography.caption.copyWith(
                        fontFeatures: AppTypography.tnum,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _thumb() {
    return ClipRRect(
      borderRadius: AppRadii.brSm,
      child: SizedBox(
        width: 48,
        height: 48,
        child: imageUrl == null
            ? Container(
                color: AppColors.surfaceVariant,
                alignment: Alignment.center,
                child: const Icon(
                  Icons.restaurant_rounded,
                  size: 20,
                  color: AppColors.outline,
                ),
              )
            : Image.network(
                imageUrl!,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => Container(
                  color: AppColors.surfaceVariant,
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.restaurant_rounded,
                    size: 20,
                    color: AppColors.outline,
                  ),
                ),
              ),
      ),
    );
  }
}
