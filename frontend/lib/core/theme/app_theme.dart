import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_radii.dart';
import 'app_spacing.dart';
import 'app_typography.dart';

abstract final class AppTheme {
  AppTheme._();

  static ThemeData get light {
    final scheme = buildAppColorScheme();
    final text = AppTypography.textTheme.apply(
      bodyColor: scheme.onSurface,
      displayColor: scheme.onSurface,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: scheme,
      scaffoldBackgroundColor: AppColors.riceWhite,
      canvasColor: AppColors.riceWhite,
      textTheme: text,
      fontFamily: 'Plus Jakarta Sans',
      fontFamilyFallback: const ['Inter'],
      visualDensity: VisualDensity.standard,
      splashFactory: InkSparkle.splashFactory,
      extensions: const [AppStateColors.light],

      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.riceWhite,
        foregroundColor: AppColors.onSurface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        toolbarHeight: 56,
        titleTextStyle: AppTypography.h3.copyWith(color: AppColors.primary),
      ),

      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.riceWhite,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.onSurfaceVariant,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        elevation: 0,
      ),

      cardTheme: CardThemeData(
        color: AppColors.surfaceContainerLowest,
        surfaceTintColor: Colors.transparent,
        shadowColor: AppColors.warmCharcoal.withValues(alpha: 0.08),
        elevation: 1,
        margin: EdgeInsets.zero,
        shape: const RoundedRectangleBorder(borderRadius: AppRadii.brLg),
      ),

      dividerTheme: const DividerThemeData(
        color: AppColors.outlineVariant,
        thickness: 1,
        space: 1,
      ),

      iconTheme: const IconThemeData(
        color: AppColors.onSurfaceVariant,
        size: 24,
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.onPrimary,
          minimumSize: const Size.fromHeight(AppSpacing.touchTarget),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.edge,
            vertical: AppSpacing.sm,
          ),
          shape: const RoundedRectangleBorder(borderRadius: AppRadii.brMd),
          textStyle: AppTypography.label,
          elevation: 0,
          disabledBackgroundColor:
              AppColors.primary.withValues(alpha: 0.38),
          disabledForegroundColor:
              AppColors.onPrimary.withValues(alpha: 0.6),
        ),
      ),

      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.onPrimary,
          minimumSize: const Size.fromHeight(AppSpacing.touchTarget),
          shape: const RoundedRectangleBorder(borderRadius: AppRadii.brMd),
          textStyle: AppTypography.label,
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          minimumSize: const Size.fromHeight(AppSpacing.touchTarget),
          side: const BorderSide(color: AppColors.outline),
          shape: const RoundedRectangleBorder(borderRadius: AppRadii.brMd),
          textStyle: AppTypography.label,
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          minimumSize: const Size(0, AppSpacing.touchTarget),
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
          textStyle: AppTypography.label,
          shape: const RoundedRectangleBorder(borderRadius: AppRadii.brMd),
        ),
      ),

      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: AppColors.onSurfaceVariant,
          minimumSize: const Size.square(AppSpacing.touchTarget),
          shape: const RoundedRectangleBorder(borderRadius: AppRadii.brFull),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceContainerLowest,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.edge,
          vertical: AppSpacing.md,
        ),
        hintStyle: AppTypography.bodyLg.copyWith(
          color: AppColors.onSurfaceVariant,
        ),
        labelStyle: AppTypography.label.copyWith(
          color: AppColors.onSurfaceVariant,
        ),
        floatingLabelStyle: AppTypography.label.copyWith(
          color: AppColors.primary,
        ),
        helperStyle: AppTypography.caption,
        errorStyle: AppTypography.caption.copyWith(color: AppColors.error),
        border: const OutlineInputBorder(
          borderRadius: AppRadii.brMd,
          borderSide: BorderSide(color: AppColors.outline),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: AppRadii.brMd,
          borderSide: BorderSide(color: AppColors.outline),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: AppRadii.brMd,
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: AppRadii.brMd,
          borderSide: BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: AppRadii.brMd,
          borderSide: BorderSide(color: AppColors.error, width: 2),
        ),
      ),

      chipTheme: ChipThemeData(
        backgroundColor: AppColors.surfaceContainerLow,
        selectedColor: AppColors.terracottaContainer,
        secondarySelectedColor: AppColors.terracottaContainer,
        disabledColor: AppColors.surfaceVariant,
        labelStyle: AppTypography.label.copyWith(
          color: AppColors.onSurfaceVariant,
        ),
        secondaryLabelStyle: AppTypography.label.copyWith(
          color: AppColors.onPrimaryFixedVariant,
        ),
        side: const BorderSide(color: AppColors.outlineVariant),
        shape: const RoundedRectangleBorder(borderRadius: AppRadii.brFull),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xs,
        ),
        showCheckmark: false,
      ),

      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? AppColors.surfaceContainerLowest
              : AppColors.surfaceContainerLowest,
        ),
        trackColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? AppColors.primaryContainer
              : AppColors.surfaceVariant,
        ),
        trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
      ),

      checkboxTheme: CheckboxThemeData(
        side: const BorderSide(color: AppColors.outline, width: 2),
        fillColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? AppColors.primary
              : Colors.transparent,
        ),
        checkColor: WidgetStateProperty.all(AppColors.onPrimary),
        shape: const RoundedRectangleBorder(borderRadius: AppRadii.brXs),
      ),

      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.primary,
        linearTrackColor: AppColors.surfaceVariant,
        circularTrackColor: AppColors.surfaceVariant,
        linearMinHeight: 6,
      ),

      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.surfaceContainer,
        surfaceTintColor: Colors.transparent,
        modalBackgroundColor: AppColors.surfaceContainer,
        shape: RoundedRectangleBorder(borderRadius: AppRadii.sheetTop),
        showDragHandle: true,
        dragHandleColor: AppColors.outlineVariant,
        clipBehavior: Clip.antiAlias,
      ),

      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.surfaceContainerLowest,
        surfaceTintColor: Colors.transparent,
        elevation: 3,
        shape: const RoundedRectangleBorder(borderRadius: AppRadii.brXl),
        titleTextStyle: AppTypography.titleMd,
        contentTextStyle: AppTypography.body,
      ),

      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.inverseSurface,
        contentTextStyle: AppTypography.body.copyWith(
          color: AppColors.inverseOnSurface,
        ),
        actionTextColor: AppColors.inversePrimary,
        behavior: SnackBarBehavior.floating,
        elevation: 2,
        shape: const RoundedRectangleBorder(borderRadius: AppRadii.brMd),
      ),

      tooltipTheme: TooltipThemeData(
        textStyle:
            AppTypography.caption.copyWith(color: AppColors.inverseOnSurface),
        decoration: BoxDecoration(
          color: AppColors.inverseSurface,
          borderRadius: AppRadii.brSm,
        ),
      ),
    );
  }
}
