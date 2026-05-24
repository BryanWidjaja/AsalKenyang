import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
    this.hint = 'Cari resep murah...',
    this.controller,
    this.onChanged,
    this.onSubmitted,
  });

  final String hint;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      textInputAction: TextInputAction.search,
      style: AppTypography.body,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: const Icon(
          Icons.search_rounded,
          size: 22,
          color: AppColors.outline,
        ),
      ),
    );
  }
}
