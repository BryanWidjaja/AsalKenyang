import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/pantry_models.dart';
import '../data/pantry_repository.dart';

class PantryState {
  const PantryState({
    this.items = const [],
    this.isLoading = false,
  });

  final List<PantryItem> items;
  final bool isLoading;

  PantryState copyWith({
    List<PantryItem>? items,
    bool? isLoading,
  }) {
    return PantryState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

final pantryControllerProvider =
    NotifierProvider<PantryController, PantryState>(PantryController.new);

class PantryController extends Notifier<PantryState> {
  /// Bumped on every user mutation. Prevents background refreshes from
  /// clobbering local changes that haven't been pushed yet.
  int _gen = 0;

  @override
  PantryState build() {
    debugPrint('[Pantry] build() called');
    _gen = 0;
    Future.microtask(() async {
      await _initialLoad();
    });
    return const PantryState();
  }

  Future<void> _initialLoad() async {
    final repository = ref.read(pantryRepositoryProvider);

    // 1. Show local items immediately
    final localItems = await repository.getLocalItems();
    state = state.copyWith(items: localItems, isLoading: false);
    debugPrint('[Pantry] loaded ${localItems.length} local items');

    // 2. Try to refresh from server — but guard with _gen
    final genBefore = _gen;
    try {
      await repository.refreshItems();
    } catch (_) {
      debugPrint('[Pantry] server refresh failed (offline)');
      return;
    }

    // Only overwrite state if no user mutations happened while waiting
    if (_gen != genBefore) {
      debugPrint('[Pantry] skipping server refresh — user mutated during load');
      return;
    }

    final refreshed = await repository.getLocalItems();
    state = state.copyWith(items: refreshed);
    debugPrint('[Pantry] refreshed from server: ${refreshed.length} items');
  }

String _getDefaultQuantity(String bahanKey) {
  final lower = bahanKey.toLowerCase();
  if (lower.contains('bawang merah') || lower.contains('bawang putih')) {
    return '1 siung';
  }
  if (lower.contains('telur')) {
    return '1 butir';
  }
  if (lower.contains('cabe') || lower.contains('cabai')) {
    return '1 buah';
  }
  if (lower.contains('bawang bombay') || lower.contains('tomat') || lower.contains('jeruk')) {
    return '1 buah';
  }
  if (lower.contains('daun')) {
    return '1 lembar';
  }
  if (lower.contains('ayam') || lower.contains('daging') || lower.contains('ikan')) {
    return '1 ekor'; // or 1 potong, but generic enough
  }
  return '1';
}

  Future<void> addItem(String bahanKey, {String? quantity}) async {
    _gen++;
    debugPrint('[Pantry] addItem($bahanKey) gen=$_gen');

    // Skip if already in the list
    if (state.items.any((e) => e.bahanKey == bahanKey)) {
      debugPrint('[Pantry] addItem: already exists, skipping');
      return;
    }

    final qtyToUse = quantity ?? _getDefaultQuantity(bahanKey);

    // Optimistic in-memory update
    final newItem = PantryItem(
      id: bahanKey,
      userId: 'local',
      bahanKey: bahanKey,
      quantity: qtyToUse,
      createdAt: DateTime.now(),
    );
    state = state.copyWith(items: [...state.items, newItem]);
    debugPrint('[Pantry] addItem: state now has ${state.items.length} items');

    // Persist — don't re-read from DB afterwards
    try {
      final repository = ref.read(pantryRepositoryProvider);
      await repository.addPantryItem(bahanKey, quantity: qtyToUse);
      debugPrint('[Pantry] addItem: DB write OK');
    } catch (e) {
      debugPrint('[Pantry] addItem: DB FAILED $e');
      // Revert
      state = state.copyWith(
        items: state.items.where((i) => i.bahanKey != bahanKey).toList(),
      );
    }
  }

  Future<void> updateQuantity(String bahanKey, String quantity) async {
    _gen++;
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
    } catch (e) {
      debugPrint('[Pantry] updateQuantity FAILED: $e');
      final repository = ref.read(pantryRepositoryProvider);
      final dbItems = await repository.getLocalItems();
      state = state.copyWith(items: dbItems);
    }
  }

  Future<void> removeItem(String bahanKey) async {
    _gen++;
    debugPrint('[Pantry] removeItem($bahanKey) gen=$_gen');

    final filtered = state.items.where((e) => e.bahanKey != bahanKey).toList();
    state = state.copyWith(items: filtered);
    debugPrint('[Pantry] removeItem: state now has ${filtered.length} items');

    try {
      final repository = ref.read(pantryRepositoryProvider);
      await repository.deletePantryItem(bahanKey);
    } catch (e) {
      debugPrint('[Pantry] removeItem FAILED: $e');
      final repository = ref.read(pantryRepositoryProvider);
      final dbItems = await repository.getLocalItems();
      state = state.copyWith(items: dbItems);
    }
  }
}
