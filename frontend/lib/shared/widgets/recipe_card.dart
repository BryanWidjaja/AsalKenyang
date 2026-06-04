import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_elevation.dart';
import '../../core/theme/app_radii.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import 'app_image.dart';
import 'tag_pill.dart';

enum PriceState { affordable, mid, unaffordable }

enum _RecipeCardVariant { feature, compact }

class RecipeCard extends StatelessWidget {
  const RecipeCard.feature({
    super.key,
    required this.title,
    required this.priceText,
    required this.priceState,
    this.imageUrl,
    this.timeText,
    this.equipmentIcon,
    this.dotsFilled = 2,
    this.onTap,
  }) : _variant = _RecipeCardVariant.feature,
       pedas = false,
       favorite = null,
       onFavoriteToggle = null;

  const RecipeCard.compact({
    super.key,
    required this.title,
    required this.priceText,
    required this.priceState,
    this.imageUrl,
    this.timeText,
    this.pedas = false,
    this.favorite,
    this.onFavoriteToggle,
    this.onTap,
  }) : _variant = _RecipeCardVariant.compact,
       equipmentIcon = null,
       dotsFilled = 0;

  final _RecipeCardVariant _variant;
  final String title;
  final String priceText;
  final PriceState priceState;
  final String? imageUrl;
  final String? timeText;
  final IconData? equipmentIcon;
  final int dotsFilled;
  final bool pedas;
  final bool? favorite;
  final VoidCallback? onFavoriteToggle;
  final VoidCallback? onTap;

  Color get _priceColor {
    switch (priceState) {
      case PriceState.affordable:
        return AppColors.secondary;
      case PriceState.mid:
        return AppColors.tertiaryContainer;
      case PriceState.unaffordable:
        return AppColors.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surfaceContainerLowest,
      borderRadius: AppRadii.brMd,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: AppRadii.brMd,
            boxShadow: AppElevation.level1,
          ),
          child: _variant == _RecipeCardVariant.feature
              ? _feature()
              : _compact(),
        ),
      ),
    );
  }

  Widget _feature() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        _Photo(
          imageUrl: imageUrl,
          overlayBottomLeft: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (timeText != null)
                _OverlayChip(icon: Icons.schedule_rounded, label: timeText),
              if (timeText != null && equipmentIcon != null)
                const SizedBox(width: AppSpacing.xs),
              if (equipmentIcon != null) _OverlayChip(icon: equipmentIcon!),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title, style: AppTypography.titleMd),
              const SizedBox(height: AppSpacing.xs),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      priceText,
                      style: AppTypography.label.copyWith(
                        color: _priceColor,
                        fontFeatures: AppTypography.tnum,
                      ),
                    ),
                  ),
                  _Dots(filled: dotsFilled, color: _priceColor),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _compact() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        _Photo(
          imageUrl: imageUrl,
          topRight: favorite != null
              ? _FavoriteButton(active: favorite!, onTap: onFavoriteToggle)
              : (pedas ? const TagPill.pedas() : null),
        ),
        Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title, style: AppTypography.label.copyWith(height: 1.2)),
              const SizedBox(height: AppSpacing.sm),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      priceText,
                      style: AppTypography.label.copyWith(
                        color: _priceColor,
                        fontFeatures: AppTypography.tnum,
                      ),
                    ),
                  ),
                  if (timeText != null) ...[
                    const Icon(
                      Icons.schedule_rounded,
                      size: 14,
                      color: AppColors.onSurfaceVariant,
                    ),
                    const SizedBox(width: 2),
                    Text(timeText!, style: AppTypography.caption),
                  ],
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Photo extends StatelessWidget {
  const _Photo({this.imageUrl, this.overlayBottomLeft, this.topRight});

  final String? imageUrl;
  final Widget? overlayBottomLeft;
  final Widget? topRight;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 10,
      child: Stack(
        fit: StackFit.expand,
        children: [
          AppImage(
            imageUrl: imageUrl,
            placeholderIcon: Icons.restaurant_rounded,
            placeholderIconSize: 40,
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.04),
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  AppColors.warmCharcoal.withValues(alpha: 0.55),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          if (overlayBottomLeft != null)
            Positioned(
              left: AppSpacing.sm,
              right: AppSpacing.sm,
              bottom: AppSpacing.sm,
              child: Align(
                alignment: Alignment.centerLeft,
                child: overlayBottomLeft,
              ),
            ),
          if (topRight != null)
            Positioned(
              top: AppSpacing.sm,
              right: AppSpacing.sm,
              child: topRight!,
            ),
        ],
      ),
    );
  }
}

class _OverlayChip extends StatelessWidget {
  const _OverlayChip({required this.icon, this.label});

  final IconData icon;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest.withValues(alpha: 0.9),
        borderRadius: AppRadii.brXs,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: AppColors.onSurfaceVariant),
          if (label != null) ...[
            const SizedBox(width: 2),
            Text(label!, style: AppTypography.caption),
          ],
        ],
      ),
    );
  }
}

class _FavoriteButton extends StatelessWidget {
  const _FavoriteButton({required this.active, this.onTap});

  final bool active;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLowest.withValues(alpha: 0.85),
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Icon(
          active ? Icons.favorite_rounded : Icons.favorite_border_rounded,
          size: 18,
          color: AppColors.primary,
        ),
      ),
    );
  }
}

class _Dots extends StatelessWidget {
  const _Dots({required this.filled, required this.color});

  static const int _total = 3;

  final int filled;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < _total; i++) ...[
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: i < filled ? color : AppColors.surfaceVariant,
              shape: BoxShape.circle,
            ),
          ),
          if (i != _total - 1) const SizedBox(width: 4),
        ],
      ],
    );
  }
}
