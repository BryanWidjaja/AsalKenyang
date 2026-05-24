import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import 'grocery_checkbox.dart';

class GroceryItem extends StatelessWidget {
  const GroceryItem({
    super.key,
    required this.name,
    required this.price,
    required this.checked,
    this.note,
    this.onChanged,
  });

  final String name;
  final String price;
  final bool checked;
  final String? note;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    final nameColor = checked ? AppColors.outline : AppColors.onSurface;
    final priceColor = checked ? AppColors.outline : AppColors.onSurface;
    return InkWell(
      onTap: onChanged == null ? null : () => onChanged!(!checked),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Row(
          children: [
            GroceryCheckbox(value: checked, onChanged: onChanged),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    name,
                    style: AppTypography.body.copyWith(
                      color: nameColor,
                      decoration:
                          checked ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  if (note != null) ...[
                    const SizedBox(height: 2),
                    Text(note!, style: AppTypography.caption),
                  ],
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Text(
              price,
              style: AppTypography.label.copyWith(
                color: priceColor,
                fontFeatures: AppTypography.tnum,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
