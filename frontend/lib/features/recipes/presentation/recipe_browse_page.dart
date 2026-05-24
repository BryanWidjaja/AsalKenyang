import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/top_bar.dart';

class RecipeBrowsePage extends StatelessWidget {
  const RecipeBrowsePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.riceWhite,
      appBar: const TopBar.shell(budgetText: 'Rp 47.000'),
      body: Center(
        child: Text(
          'Recipes page',
          style: AppTypography.h2.copyWith(color: AppColors.primary),
        ),
      ),
    );
  }
}
