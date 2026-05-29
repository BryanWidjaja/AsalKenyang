import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_elevation.dart';
import '../../../core/theme/app_radii.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/filter_pill.dart';
import '../../../shared/widgets/top_bar.dart';
import '../application/pantry_controller.dart';
import '../data/ingredient_catalog.dart';

class PantryPage extends ConsumerWidget {
  const PantryPage({super.key});

  static const String route = '/pantry-saved';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pantryState = ref.watch(pantryControllerProvider);
    final items = pantryState.items;

    return Scaffold(
      backgroundColor: AppColors.riceWhite,
      appBar: const TopBar.nested(title: 'Bahan Tersimpan'),
      body: SafeArea(
        top: false,
        child: items.isEmpty
            ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.kitchen_rounded,
                      size: 64,
                      color: AppColors.onSurfaceVariant.withValues(alpha: 0.4),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      'Belum ada bahan tersimpan',
                      style: AppTypography.body.copyWith(
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      'Tekan tombol di bawah untuk menambah',
                      style: AppTypography.caption,
                    ),
                  ],
                ),
              )
            : ListView.separated(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.edge,
                  vertical: AppSpacing.md,
                ),
                itemCount: items.length,
                separatorBuilder: (context, index) => Divider(
                  color: AppColors.outlineVariant.withValues(alpha: 0.4),
                  height: AppSpacing.lg,
                ),
                itemBuilder: (context, index) {
                  final item = items[index];
                  final def = findIngredientByKey(item.bahanKey);
                  final label = def?.label ?? item.bahanKey;
                  final icon = def?.icon ?? Icons.eco_rounded;

                  return _PantryItemTile(
                    label: label,
                    icon: icon,
                    bahanKey: item.bahanKey,
                    quantity: item.quantity,
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openAddSheet(context),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
        icon: const Icon(Icons.add_rounded),
        label: const Text('Tambah Bahan'),
      ),
    );
  }

  void _openAddSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetCtx) => const _AddIngredientSheet(),
    );
  }
}

// ─── Single item row ────────────────────────────────────────────────────────

class _PantryItemTile extends ConsumerStatefulWidget {
  const _PantryItemTile({
    required this.label,
    required this.icon,
    required this.bahanKey,
    required this.quantity,
  });

  final String label;
  final IconData icon;
  final String bahanKey;
  final String? quantity;

  @override
  ConsumerState<_PantryItemTile> createState() => _PantryItemTileState();
}

class _PantryItemTileState extends ConsumerState<_PantryItemTile> {
  late TextEditingController _qtyCtrl;

  String get _displayQty {
    final quantity = widget.quantity?.trim();
    if (quantity == null || quantity.isEmpty) {
      return defaultQuantityForIngredient(widget.bahanKey);
    }

    if (RegExp(r'^\d+(?:[,.]\d+)?$').hasMatch(quantity)) {
      final defaultUnit = _unitFrom(
        defaultQuantityForIngredient(widget.bahanKey),
      );
      return defaultUnit.isEmpty ? quantity : '$quantity $defaultUnit';
    }

    return quantity;
  }

  String get _parsedNum {
    final match = RegExp(r'^(\d+(?:[,.]\d+)?)\s*(.*)$').firstMatch(_displayQty);
    return match != null ? match.group(1)! : _displayQty;
  }

  String get _parsedUnit {
    final match = RegExp(r'^(\d+(?:[,.]\d+)?)\s*(.*)$').firstMatch(_displayQty);
    return match != null ? match.group(2)!.trim() : '';
  }

  @override
  void initState() {
    super.initState();
    _qtyCtrl = TextEditingController(text: _parsedNum);
  }

  @override
  void didUpdateWidget(covariant _PantryItemTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.quantity != widget.quantity) {
      if (_qtyCtrl.text != _parsedNum) {
        _qtyCtrl.text = _parsedNum;
      }
    }
  }

  @override
  void dispose() {
    _qtyCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Icon circle
        Container(
          width: 48,
          height: 48,
          decoration: const BoxDecoration(
            color: AppColors.surfaceContainer,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Icon(widget.icon, color: AppColors.primary, size: 24),
        ),
        const SizedBox(width: AppSpacing.md),

        // Name
        Expanded(child: Text(widget.label, style: AppTypography.subtitle)),
        const SizedBox(width: AppSpacing.sm),

        // Editable quantity field
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 50,
              child: TextField(
                controller: _qtyCtrl,
                textAlign: TextAlign.center,
                style: AppTypography.label.copyWith(
                  fontFeatures: AppTypography.tnum,
                ),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 8,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: AppColors.outlineVariant),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: AppColors.outlineVariant),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: AppColors.primary,
                      width: 1.5,
                    ),
                  ),
                ),
                onSubmitted: (value) {
                  final trimmed = value.trim();
                  if (trimmed.isNotEmpty && trimmed != _parsedNum) {
                    final finalQty = _parsedUnit.isEmpty
                        ? trimmed
                        : '$trimmed $_parsedUnit';
                    ref
                        .read(pantryControllerProvider.notifier)
                        .updateQuantity(widget.bahanKey, finalQty);
                  }
                },
              ),
            ),
            if (_parsedUnit.isNotEmpty) ...[
              const SizedBox(width: AppSpacing.xs),
              Text(
                _parsedUnit,
                style: AppTypography.caption.copyWith(
                  color: AppColors.onSurfaceVariant,
                ),
              ),
            ],
          ],
        ),
        const SizedBox(width: AppSpacing.xs),

        // Delete
        IconButton(
          onPressed: () {
            ref
                .read(pantryControllerProvider.notifier)
                .removeItem(widget.bahanKey);
          },
          icon: const Icon(Icons.close_rounded, size: 20),
          color: AppColors.onSurfaceVariant,
          tooltip: 'Hapus',
          visualDensity: VisualDensity.compact,
        ),
      ],
    );
  }
}

// ─── Bottom sheet for adding new ingredients ─────────────────────────────────

String _unitFrom(String quantity) {
  final match = RegExp(r'^\s*\d+(?:[,.]\d+)?\s*(.*)$').firstMatch(quantity);
  return match == null ? '' : match.group(1)!.trim();
}

class _AddIngredientSheet extends ConsumerStatefulWidget {
  const _AddIngredientSheet();

  @override
  ConsumerState<_AddIngredientSheet> createState() =>
      _AddIngredientSheetState();
}

class _AddIngredientSheetState extends ConsumerState<_AddIngredientSheet> {
  String _category = 'Semua';

  List<IngredientDef> get _visible {
    if (_category == 'Semua') return ingredientCatalog;
    return ingredientCatalog.where((i) => i.category == _category).toList();
  }

  @override
  Widget build(BuildContext context) {
    final pantryState = ref.watch(pantryControllerProvider);
    final selectedKeys = pantryState.items.map((e) => e.bahanKey).toSet();

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: DraggableScrollableSheet(
        initialChildSize: 0.75,
        minChildSize: 0.4,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) {
          return Column(
            children: [
              const SizedBox(height: AppSpacing.sm),
              // Drag handle
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.outlineVariant,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Text('Tambah Bahan', style: AppTypography.titleMd),
              const SizedBox(height: AppSpacing.md),

              // Category filters
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.edge,
                ),
                child: Row(
                  children: [
                    for (final c in ingredientCategories) ...[
                      FilterPill(
                        label: c,
                        selected: _category == c,
                        onTap: () => setState(() => _category = c),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),

              // Ingredient list
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.edge,
                    vertical: AppSpacing.sm,
                  ),
                  itemCount: _visible.length,
                  itemBuilder: (context, index) {
                    final def = _visible[index];
                    final isSelected = selectedKeys.contains(def.key);

                    return Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: AppRadii.brMd,
                          onTap: () async {
                            if (isSelected) {
                              await ref
                                  .read(pantryControllerProvider.notifier)
                                  .removeItem(def.key);
                            } else {
                              await ref
                                  .read(pantryControllerProvider.notifier)
                                  .addItem(def.key);
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.md,
                              vertical: AppSpacing.sm,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.terracottaContainer.withValues(
                                      alpha: 0.5,
                                    )
                                  : AppColors.surfaceContainerLowest,
                              borderRadius: AppRadii.brMd,
                              border: Border.all(
                                color: isSelected
                                    ? AppColors.primary.withValues(alpha: 0.3)
                                    : AppColors.outlineVariant.withValues(
                                        alpha: 0.3,
                                      ),
                              ),
                              boxShadow: AppElevation.level1,
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? AppColors.terracottaContainer
                                        : AppColors.surfaceContainer,
                                    shape: BoxShape.circle,
                                  ),
                                  alignment: Alignment.center,
                                  child: Icon(
                                    def.icon,
                                    color: isSelected
                                        ? AppColors.primary
                                        : AppColors.onSurfaceVariant,
                                    size: 22,
                                  ),
                                ),
                                const SizedBox(width: AppSpacing.md),
                                Expanded(
                                  child: Text(
                                    def.label,
                                    style: AppTypography.label,
                                  ),
                                ),
                                Icon(
                                  isSelected
                                      ? Icons.check_circle_rounded
                                      : Icons.add_circle_outline_rounded,
                                  color: isSelected
                                      ? AppColors.primary
                                      : AppColors.onSurfaceVariant,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
