import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../plan/application/plan_controller.dart';
import '../../pantry/application/pantry_controller.dart';
import '../data/grocery_models.dart';
import '../data/grocery_repository.dart';

class GroceryAggregatedItem {
  const GroceryAggregatedItem({
    required this.bahanKey,
    required this.name,
    required this.price,
    required this.quantity,
    required this.unitPrice,
    required this.unitName,
    required this.isChecked,
  });
  final String bahanKey;
  final String name;
  final int price;
  final String quantity;
  final int unitPrice;
  final String unitName;
  final bool isChecked;
}

final groceryStatesProvider = StreamProvider<List<GroceryItemState>>((ref) {
  return ref.watch(groceryRepositoryProvider).watchGroceryStates();
});

final groceryListProvider = Provider<List<GroceryAggregatedItem>>((ref) {
  final planDetails = ref.watch(planDetailsProvider);
  final groceryStates = ref.watch(groceryStatesProvider).value ?? [];

  return aggregateGroceryItems(planDetails, groceryStates);
});

List<GroceryAggregatedItem> aggregateGroceryItems(
  Iterable<PlannedMealDetail> planDetails,
  List<GroceryItemState> groceryStates,
) {
  final groupedBahan = <String, List<_BahanNeed>>{};

  for (final detail in planDetails) {
    final fallbackPrice = detail.recipe.bahan.isEmpty
        ? 0
        : (detail.recipe.estPrice / detail.recipe.bahan.length).round();
    for (final bahan in detail.recipe.bahan) {
      final bahanKey = bahan.key;
      final price = bahan.harga > 0 ? bahan.harga : fallbackPrice;
      groupedBahan
          .putIfAbsent(bahanKey, () => [])
          .add(
            _BahanNeed(
              name: bahan.nama,
              quantity: _shoppingQuantityLabel(bahan.jumlah, bahan.gram),
              price: price,
            ),
          );
    }
  }

  return groupedBahan.entries.map((entry) {
    final state = groceryStates.firstWhere(
      (candidate) => candidate.bahanKey == entry.key,
      orElse: () => GroceryItemState(bahanKey: entry.key, isChecked: false),
    );
    final needs = entry.value;
    final totalPrice = needs.fold<int>(0, (sum, item) => sum + item.price);
    final quantity = _quantityLabel(
      needs.map((item) => item.quantity).toList(),
    );
    final parsed = _summedQuantity(needs.map((item) => item.quantity).toList());
    final unitPriceBase = parsed == null || parsed.amount <= 0
        ? needs.length
        : parsed.amount;
    final unitPrice = unitPriceBase <= 0
        ? totalPrice
        : (totalPrice / unitPriceBase).round();

    return GroceryAggregatedItem(
      bahanKey: entry.key,
      name: needs.first.name,
      price: totalPrice,
      quantity: quantity,
      unitPrice: unitPrice,
      unitName: parsed?.unit ?? 'item',
      isChecked: state.isChecked,
    );
  }).toList();
}

final groceryTotalCostProvider = Provider<int>((ref) {
  final items = ref.watch(groceryListProvider);
  return items.fold(0, (sum, item) => sum + item.price);
});

final groceryControllerProvider = Provider<GroceryController>((ref) {
  return GroceryController(ref.watch(groceryRepositoryProvider), ref);
});

class GroceryController {
  const GroceryController(this._repo, this._ref);
  final GroceryRepository _repo;
  final Ref _ref;

  Future<void> toggleCheck(String bahanKey, bool isChecked) async {
    await _repo.setChecked(bahanKey, isChecked);

    if (isChecked) {
      final items = _ref.read(groceryListProvider);
      final groceryItem = items
          .where((item) => item.bahanKey == bahanKey)
          .firstOrNull;
      final quantity = groceryItem?.quantity ?? '1';

      await _ref
          .read(pantryControllerProvider.notifier)
          .addItem(bahanKey, quantity: quantity);
    }
  }
}

String _shoppingQuantityLabel(String quantity, double? grams) {
  final trimmed = quantity.trim();

  if (!_needsEstimatedQuantity(trimmed)) {
    return trimmed;
  }

  final estimate = _gramQuantityLabel(grams);
  return estimate ?? (trimmed.isEmpty ? '1 item' : trimmed);
}

bool _needsEstimatedQuantity(String quantity) {
  final normalized = quantity.trim().toLowerCase();

  if (normalized.isEmpty) {
    return true;
  }

  if (normalized == 'secukupnya' || normalized == 'sesuai selera') {
    return true;
  }

  if (normalized.contains('secukupnya')) {
    return true;
  }

  if (normalized.contains('sesuai selera')) {
    return true;
  }

  return !RegExp(r'\d').hasMatch(normalized);
}

String? _gramQuantityLabel(double? grams) {
  if (grams == null || grams <= 0) {
    return null;
  }

  if (grams >= 1000) {
    final kg = grams / 1000;
    final amount = kg % 1 == 0
        ? kg.toStringAsFixed(0)
        : kg.toStringAsFixed(1).replaceAll('.', ',');
    return '$amount kg';
  }
  final amount = grams % 1 == 0
      ? grams.toStringAsFixed(0)
      : grams.toStringAsFixed(1).replaceAll('.', ',');
  return '$amount g';
}

class _BahanNeed {
  const _BahanNeed({
    required this.name,
    required this.quantity,
    required this.price,
  });

  final String name;
  final String quantity;
  final int price;
}

class _ParsedQuantity {
  const _ParsedQuantity(this.amount, this.unit);

  final double amount;
  final String unit;
}

String _quantityLabel(List<String> quantities) {
  final parsed = _summedQuantity(quantities);
  if (parsed != null) {
    final amount = parsed.amount % 1 == 0
        ? parsed.amount.toStringAsFixed(0)
        : parsed.amount.toStringAsFixed(1).replaceAll('.', ',');
    return '$amount ${parsed.unit}'.trim();
  }

  final unique = quantities.toSet();
  if (unique.length == 1 && quantities.length > 1) {
    return '${quantities.length} x ${quantities.first}';
  }
  return quantities.join(' + ');
}

_ParsedQuantity? _summedQuantity(List<String> quantities) {
  if (quantities.isEmpty) {
    return null;
  }

  final parsed = <_ParsedQuantity>[];
  for (final quantity in quantities) {
    final match = RegExp(
      r'^\s*(\d+(?:[,.]\d+)?)\s*(.*)$',
      caseSensitive: false,
    ).firstMatch(quantity);

    if (match == null) {
      return null;
    }

    final amount = double.tryParse(match.group(1)!.replaceAll(',', '.'));
    final unit = match.group(2)!.trim().toLowerCase();

    if (amount == null || unit.isEmpty) {
      return null;
    }

    parsed.add(_ParsedQuantity(amount, unit));
  }

  final unit = parsed.first.unit;
  if (parsed.any((item) => item.unit != unit)) {
    return null;
  }

  return _ParsedQuantity(
    parsed.fold<double>(0, (sum, item) => sum + item.amount),
    unit,
  );
}
