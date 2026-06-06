import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_elevation.dart';
import '../../core/theme/app_radii.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';

class BottomNavDestination {
  const BottomNavDestination({
    required this.label,
    required this.icon,
    required this.activeIcon,
  });

  final String label;
  final IconData icon;
  final IconData activeIcon;
}

class BottomNav extends StatelessWidget {
  const BottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.destinations = _defaultDestinations,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<BottomNavDestination> destinations;

  static const List<BottomNavDestination> _defaultDestinations = [
    BottomNavDestination(
      label: 'Masak',
      icon: Icons.soup_kitchen_outlined,
      activeIcon: Icons.soup_kitchen_rounded,
    ),
    BottomNavDestination(
      label: 'Resep',
      icon: Icons.menu_book_outlined,
      activeIcon: Icons.menu_book_rounded,
    ),
    BottomNavDestination(
      label: 'Rencana',
      icon: Icons.calendar_month_outlined,
      activeIcon: Icons.calendar_month_rounded,
    ),
    BottomNavDestination(
      label: 'Belanja',
      icon: Icons.shopping_cart_outlined,
      activeIcon: Icons.shopping_cart_rounded,
    ),
    BottomNavDestination(
      label: 'Profil',
      icon: Icons.person_outline_rounded,
      activeIcon: Icons.person_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.riceWhite,
        borderRadius: AppRadii.navTop,
        boxShadow: AppElevation.nav,
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64,
          child: Center(
            child: ConstrainedBox(
              constraints:
                  const BoxConstraints(maxWidth: AppSpacing.screenMaxWidth),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    for (var index = 0; index < destinations.length; index++)
                      _NavItem(
                        destination: destinations[index],
                        active: index == currentIndex,
                        onTap: () => onTap(index),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.destination,
    required this.active,
    required this.onTap,
  });

  final BottomNavDestination destination;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    if (active) {
      return InkWell(
        onTap: onTap,
        borderRadius: AppRadii.brFull,
        child: Container(
          height: 48,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.edge,
            vertical: AppSpacing.xs,
          ),
          decoration: const BoxDecoration(
            color: AppColors.terracottaContainer,
            borderRadius: AppRadii.brFull,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                destination.activeIcon,
                size: 24,
                color: AppColors.onPrimaryFixedVariant,
              ),
              const SizedBox(height: 2),
              Text(
                destination.label,
                style: AppTypography.overline.copyWith(
                  color: AppColors.onPrimaryFixedVariant,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      );
    }
    return InkWell(
      onTap: onTap,
      borderRadius: AppRadii.brMd,
      child: SizedBox(
        width: 64,
        height: 64,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              destination.icon,
              size: 24,
              color: AppColors.onSurfaceVariant,
            ),
            const SizedBox(height: 4),
            Text(
              destination.label,
              style: AppTypography.overline.copyWith(
                color: AppColors.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
