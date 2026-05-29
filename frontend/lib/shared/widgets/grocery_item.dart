import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import 'grocery_checkbox.dart';

class GroceryItem extends StatelessWidget {
  const GroceryItem({
    super.key,
    required this.name,
    required this.quantity,
    required this.price,
    required this.checked,
    this.note,
    this.onChanged,
  });

  final String name;
  final String quantity;
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
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          name,
                          style: AppTypography.body.copyWith(
                            color: nameColor,
                            decoration: checked
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Text(
                        quantity,
                        style: AppTypography.label.copyWith(
                          color: priceColor,
                          fontFeatures: AppTypography.tnum,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(price, style: AppTypography.caption),
                  if (note != null) Text(note!, style: AppTypography.caption),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
