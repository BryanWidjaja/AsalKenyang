import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_elevation.dart';
import '../../core/theme/app_radii.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import 'match_ring.dart';
import 'missing_chip.dart';

class MatchResultRow extends StatelessWidget {
  const MatchResultRow({
    super.key,
    required this.title,
    required this.missing,
    required this.matchPercent,
    this.imageUrl,
    this.onTap,
    this.maxMissingShown = 2,
  });

  final String title;
  final List<String> missing;
  final double matchPercent;
  final String? imageUrl;
  final VoidCallback? onTap;
  final int maxMissingShown;

  @override
  Widget build(BuildContext context) {
    final shown = missing.take(maxMissingShown).toList();
    final overflow = missing.length - shown.length;

    return Material(
      color: AppColors.surfaceContainerLowest,
      borderRadius: AppRadii.brMd,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadii.brMd,
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            borderRadius: AppRadii.brMd,
            border: Border.all(color: AppColors.surfaceContainerHigh),
            boxShadow: AppElevation.level1,
          ),
          child: Row(
            children: [
              _Thumb(imageUrl: imageUrl),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTypography.label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (missing.isNotEmpty) ...[
                      const SizedBox(height: AppSpacing.xs),
                      Wrap(
                        spacing: AppSpacing.xs,
                        runSpacing: AppSpacing.xs,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text('Kurang:', style: AppTypography.caption),
                          for (final m in shown) MissingChip(label: m),
                          if (overflow > 0) MissingChip(label: '+$overflow lagi'),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              MatchRing(percent: matchPercent),
            ],
          ),
        ),
      ),
    );
  }
}

class _Thumb extends StatelessWidget {
  const _Thumb({this.imageUrl});

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: AppRadii.brSm,
      child: SizedBox(
        width: 56,
        height: 56,
        child: imageUrl == null
            ? Container(
                color: AppColors.surfaceVariant,
                alignment: Alignment.center,
                child: const Icon(
                  Icons.restaurant_rounded,
                  size: 24,
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
                    size: 24,
                    color: AppColors.outline,
                  ),
                ),
              ),
      ),
    );
  }
}
