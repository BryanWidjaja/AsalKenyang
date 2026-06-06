import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radii.dart';

class BudgetGauge extends StatelessWidget {
  const BudgetGauge({
    super.key,
    required this.percent,
    this.height = 8,
    this.animate = true,
  });

  final double percent;
  final double height;
  final bool animate;

  Color _fillColor(AppStateColors state) {
    if (percent > 0.5) {
      return state.gauge1;
    }

    if (percent >= 0.2) {
      return state.gauge2;
    }

    if (percent > 0) {
      return state.gauge3;
    }

    return state.gauge4;
  }

  @override
  Widget build(BuildContext context) {
    final color = _fillColor(AppStateColors.of(context));
    final target = percent.clamp(0.0, 1.0);
    return ClipRRect(
      borderRadius: AppRadii.brFull,
      child: SizedBox(
        height: height,
        child: ColoredBox(
          color: AppColors.surfaceVariant,
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: target),
            duration: animate
                ? const Duration(milliseconds: 400)
                : Duration.zero,
            curve: Curves.easeOut,
            builder: (context, value, _) => FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: value,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: AppRadii.brFull,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
