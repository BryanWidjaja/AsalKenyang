import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import 'budget_chip.dart';

enum _TopBarVariant { shell, nested, detail }

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  const TopBar.shell({
    super.key,
    required this.budgetText,
    this.onWalletTap,
    this.onBudgetTap,
  })  : _variant = _TopBarVariant.shell,
        title = 'Warung Hangat',
        onBack = null,
        trailing = null,
        isFavorited = false,
        onFavoriteToggle = null;

  const TopBar.nested({
    super.key,
    required this.title,
    this.onBack,
    this.trailing,
  })  : _variant = _TopBarVariant.nested,
        budgetText = null,
        onWalletTap = null,
        onBudgetTap = null,
        isFavorited = false,
        onFavoriteToggle = null;

  const TopBar.detail({
    super.key,
    this.onBack,
    required this.isFavorited,
    this.onFavoriteToggle,
    this.title = 'Resep',
  })  : _variant = _TopBarVariant.detail,
        trailing = null,
        budgetText = null,
        onWalletTap = null,
        onBudgetTap = null;

  final _TopBarVariant _variant;
  final String title;
  final String? budgetText;
  final VoidCallback? onWalletTap;
  final VoidCallback? onBudgetTap;
  final VoidCallback? onBack;
  final Widget? trailing;
  final bool isFavorited;
  final VoidCallback? onFavoriteToggle;

  static const double _height = 56;

  @override
  Size get preferredSize => const Size.fromHeight(_height);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.riceWhite,
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: _height,
          child: Center(
            child: ConstrainedBox(
              constraints:
                  const BoxConstraints(maxWidth: AppSpacing.screenMaxWidth),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: AppSpacing.edge),
                child: _buildContent(context),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    switch (_variant) {
      case _TopBarVariant.shell:
        return _shell();
      case _TopBarVariant.nested:
        return _nested(context);
      case _TopBarVariant.detail:
        return _detail(context);
    }
  }

  Widget _shell() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Align(
          alignment: Alignment.center,
          child: Text(
            title,
            style: AppTypography.h3.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: IconButton(
            onPressed: onWalletTap,
            icon: const Icon(
              Icons.account_balance_wallet_rounded,
              color: AppColors.primary,
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: BudgetChip(
            amount: budgetText ?? 'Rp 0',
            onTap: onBudgetTap,
          ),
        ),
      ],
    );
  }

  Widget _nested(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Align(
          alignment: Alignment.center,
          child: Text(
            title,
            style: AppTypography.h3.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: IconButton(
            onPressed: onBack ?? () => Navigator.of(context).maybePop(),
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: AppColors.primary,
            ),
          ),
        ),
        if (trailing != null)
          Align(alignment: Alignment.centerRight, child: trailing),
      ],
    );
  }

  Widget _detail(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Align(
          alignment: Alignment.center,
          child: Text(
            title,
            style: AppTypography.h3.copyWith(color: AppColors.onSurface),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: IconButton(
            onPressed: onBack ?? () => Navigator.of(context).maybePop(),
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: AppColors.onSurface,
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            onPressed: onFavoriteToggle,
            icon: Icon(
              isFavorited
                  ? Icons.favorite_rounded
                  : Icons.favorite_border_rounded,
              color: AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }
}
