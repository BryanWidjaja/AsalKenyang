import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';

class RecipeBrowsePage extends StatelessWidget {
  const RecipeBrowsePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.riceWhite,
      body: Center(
        child: Text(
          'Recipes page',
          style: AppTypography.h2.copyWith(color: AppColors.primary),
        ),
      ),
    );
  }
}
