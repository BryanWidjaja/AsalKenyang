import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class BrandMark extends StatelessWidget {
  const BrandMark({
    super.key,
    this.size = 64,
    this.icon = Icons.restaurant_rounded,
    this.squircle = false,
  });

  const BrandMark.splash({super.key})
      : size = 100,
        icon = Icons.restaurant_rounded,
        squircle = true;

  final double size;
  final IconData icon;
  final bool squircle;

  @override
  Widget build(BuildContext context) {
    final radius = squircle ? size * 0.32 : size / 2;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.terracottaContainer,
        borderRadius: BorderRadius.circular(radius),
      ),
      alignment: Alignment.center,
      child: Icon(
        icon,
        size: size * 0.5,
        color: AppColors.primary,
      ),
    );
  }
}
