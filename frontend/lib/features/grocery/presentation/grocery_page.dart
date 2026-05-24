import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';

class GroceryPage extends StatelessWidget {
  const GroceryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.riceWhite,
      body: Center(
        child: Text(
          'Grocery page',
          style: AppTypography.h2.copyWith(color: AppColors.primary),
        ),
      ),
    );
  }
}
