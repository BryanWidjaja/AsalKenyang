import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class AppImage extends StatelessWidget {
  const AppImage({
    super.key,
    required this.imageUrl,
    required this.placeholderIcon,
    this.fit = BoxFit.cover,
    this.placeholderIconSize = 32,
  });

  final String? imageUrl;
  final IconData placeholderIcon;
  final BoxFit fit;
  final double placeholderIconSize;

  @override
  Widget build(BuildContext context) {
    final source = imageUrl?.trim();

    if (source == null || source.isEmpty) {
      return _placeholder();
    }

    if (_isAssetPath(source)) {
      return Image.asset(source, fit: fit, errorBuilder: _errorBuilder);
    }

    return Image.network(source, fit: fit, errorBuilder: _errorBuilder);
  }

  bool _isAssetPath(String source) {
    return source.startsWith('assets/');
  }

  Widget _placeholder() {
    return Container(
      color: AppColors.surfaceVariant,
      alignment: Alignment.center,
      child: Icon(
        placeholderIcon,
        size: placeholderIconSize,
        color: AppColors.outline,
      ),
    );
  }

  Widget _errorBuilder(
    BuildContext context,
    Object error,
    StackTrace? stackTrace,
  ) {
    return _placeholder();
  }
}
