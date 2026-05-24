import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.riceWhite,
      body: Center(
        child: Text(
          'Profile page',
          style: AppTypography.h2.copyWith(color: AppColors.primary),
        ),
      ),
    );
  }
}
