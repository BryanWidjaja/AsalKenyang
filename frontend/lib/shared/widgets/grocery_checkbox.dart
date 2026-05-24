import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radii.dart';

class GroceryCheckbox extends StatelessWidget {
  const GroceryCheckbox({super.key, required this.value, this.onChanged});

  final bool value;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onChanged == null ? null : () => onChanged!(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: value ? AppColors.primary : Colors.transparent,
          borderRadius: AppRadii.brXs,
          border: Border.all(
            color: value ? AppColors.primary : AppColors.outline,
            width: 2,
          ),
        ),
        child: value
            ? const Icon(Icons.check_rounded, size: 16, color: AppColors.onPrimary)
            : null,
      ),
    );
  }
}
