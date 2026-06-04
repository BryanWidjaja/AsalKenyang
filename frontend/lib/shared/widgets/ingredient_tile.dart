import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_elevation.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';

class IngredientTile extends StatelessWidget {
  const IngredientTile({
    super.key,
    required this.label,
    required this.icon,
    required this.selected,
    this.onTap,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: selected
                          ? AppColors.terracottaContainer
                          : AppColors.surfaceContainerLowest,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: AppColors.primary.withValues(
                          alpha: selected ? 0.1 : 0.04,
                        ),
                      ),
                      boxShadow: AppElevation.level1,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.xs,
                      vertical: AppSpacing.sm,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          icon,
                          size: 22,
                          color: selected
                              ? AppColors.primary
                              : AppColors.onSurfaceVariant,
                        ),
                        const SizedBox(height: 3),
                        Flexible(
                          child: Text(
                            label,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: AppTypography.caption.copyWith(
                              color: selected
                                  ? AppColors.primary
                                  : AppColors.onSurfaceVariant,
                              fontWeight: selected
                                  ? FontWeight.w700
                                  : FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (selected)
                    Positioned(
                      top: -4,
                      right: -4,
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.riceWhite,
                            width: 2,
                          ),
                          boxShadow: AppElevation.level1,
                        ),
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.check_rounded,
                          size: 12,
                          color: AppColors.onPrimary,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
