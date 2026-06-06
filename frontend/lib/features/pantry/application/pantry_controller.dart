import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/ingredient_catalog.dart';
import '../data/pantry_models.dart';
import '../data/pantry_repository.dart';

class PantryState {
  const PantryState({this.items = const [], this.isLoading = false});

  final List<PantryItem> items;
  final bool isLoading;

  PantryState copyWith({List<PantryItem>? items, bool? isLoading}) {
    return PantryState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

final pantryControllerProvider =
    NotifierProvider<PantryController, PantryState>(PantryController.new);

class PantryController extends Notifier<PantryState> {
  int _generation = 0;

  @override
  PantryState build() {
    debugPrint('[Pantry] build() called');
    _generation = 0;
    Future.microtask(() async {
      await _initialLoad();
    });
    return const PantryState();
  }

  Future<void> _initialLoad() async {
    final repository = ref.read(pantryRepositoryProvider);

    final localItems = await repository.getLocalItems();
    state = state.copyWith(items: localItems, isLoading: false);
    debugPrint('[Pantry] loaded ${localItems.length} local items');

    final generationBefore = _generation;
    try {
      await repository.refreshItems();
    } catch (_) {
      debugPrint('[Pantry] server refresh failed (offline)');
      return;
    }

    if (_generation != generationBefore) {
      debugPrint('[Pantry] skipping server refresh — user mutated during load');
      return;
    }

    final refreshed = await repository.getLocalItems();
    state = state.copyWith(items: refreshed);
    debugPrint('[Pantry] refreshed from server: ${refreshed.length} items');
  }

  Future<void> addItem(String bahanKey, {String? quantity}) async {
    _generation++;
    debugPrint('[Pantry] addItem($bahanKey) gen=$_generation');

    if (state.items.any((item) => item.bahanKey == bahanKey)) {
      debugPrint('[Pantry] addItem: already exists, skipping');
      return;
    }

    final quantityToUse = quantity ?? defaultQuantityForIngredient(bahanKey);

    final newItem = PantryItem(
      id: bahanKey,
      userId: 'local',
      bahanKey: bahanKey,
      quantity: quantityToUse,
      createdAt: DateTime.now(),
    );
    state = state.copyWith(items: [...state.items, newItem]);
    debugPrint('[Pantry] addItem: state now has ${state.items.length} items');

    try {
      final repository = ref.read(pantryRepositoryProvider);
      await repository.addPantryItem(bahanKey, quantity: quantityToUse);
      debugPrint('[Pantry] addItem: DB write OK');
    } catch (error) {
      debugPrint('[Pantry] addItem: DB FAILED $error');
      state = state.copyWith(
        items: state.items.where((item) => item.bahanKey != bahanKey).toList(),
      );
    }
  }

  Future<void> updateQuantity(String bahanKey, String quantity) async {
    _generation++;
    debugPrint('[Pantry] updateQuantity($bahanKey, $quantity)');

    final updated = state.items.map((item) {
      if (item.bahanKey == bahanKey) {
        return PantryItem(
          id: item.id,
          userId: item.userId,
          bahanKey: item.bahanKey,
          quantity: quantity,
          createdAt: item.createdAt,
        );
      }
      return item;
    }).toList();
    state = state.copyWith(items: updated);

    try {
      final repository = ref.read(pantryRepositoryProvider);
      await repository.upsertPantryItem(bahanKey, quantity);
    } catch (error) {
      debugPrint('[Pantry] updateQuantity FAILED: $error');
      final repository = ref.read(pantryRepositoryProvider);
      final dbItems = await repository.getLocalItems();
      state = state.copyWith(items: dbItems);
    }
  }

  Future<void> removeItem(String bahanKey) async {
    _generation++;
    debugPrint('[Pantry] removeItem($bahanKey) gen=$_generation');

    final filtered = state.items
        .where((item) => item.bahanKey != bahanKey)
        .toList();
    state = state.copyWith(items: filtered);
    debugPrint('[Pantry] removeItem: state now has ${filtered.length} items');

    try {
      final repository = ref.read(pantryRepositoryProvider);
      await repository.deletePantryItem(bahanKey);
    } catch (error) {
      debugPrint('[Pantry] removeItem FAILED: $error');
      final repository = ref.read(pantryRepositoryProvider);
      final dbItems = await repository.getLocalItems();
      state = state.copyWith(items: dbItems);
    }
  }
}
