import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import 'bottom_nav.dart';
import 'top_bar.dart';

class PageScaffold extends StatelessWidget {
  const PageScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.bottomNav,
    this.floatingActionButton,
    this.padding = const EdgeInsets.fromLTRB(
      AppSpacing.edge,
      AppSpacing.md,
      AppSpacing.edge,
      AppSpacing.xl,
    ),
  });

  final Widget body;
  final TopBar? appBar;
  final BottomNav? bottomNav;
  final Widget? floatingActionButton;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.riceWhite,
      appBar: appBar,
      bottomNavigationBar: bottomNav,
      floatingActionButton: floatingActionButton,
      body: SafeArea(
        top: appBar == null,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: AppSpacing.screenMaxWidth),
            child: Padding(
              padding: padding,
              child: body,
            ),
          ),
        ),
      ),
    );
  }
}
