import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/db/app_database.dart';
import '../../../core/di/providers.dart';
import '../../budget/data/budget_repository.dart';
import 'pantry_models.dart';

final pantryRemoteSourceProvider = Provider<PantryRemoteSource>((ref) {
  return PantryRemoteSource(ref.watch(dioProvider));
});

final pantryRepositoryProvider = Provider<PantryRepository>((ref) {
  return PantryRepository(
    ref.watch(appDatabaseProvider),
    ref.watch(pantryRemoteSourceProvider),
  );
});

class PantryRemoteSource {
  const PantryRemoteSource(this._dio);
  final Dio _dio;

  Future<List<PantryItem>> getItems() async {
    final res = await _dio.get('/pantry');
    final data = Map<String, dynamic>.from(res.data as Map);
    final items = data['items'] as List? ?? const [];
    return items.map((item) {
      final map = item as Map<String, dynamic>;
      final bahanKey = map['bahanKey'] as String;
      final quantity = map['quantity'] as String?;
      return PantryItem(
        id: bahanKey,
        userId: 'server',
        bahanKey: bahanKey,
        quantity: quantity,
        createdAt: DateTime.now(),
      );
    }).toList();
  }

  Future<List<PantryItem>> replaceItems(List<PantryItem> items) async {
    final payload = items
        .map((i) => {'bahanKey': i.bahanKey, 'quantity': i.quantity})
        .toList();
    final res = await _dio.put('/pantry', data: {'items': payload});
    final data = Map<String, dynamic>.from(res.data as Map);
    final resItems = data['items'] as List? ?? const [];
    return resItems.map((item) {
      final map = item as Map<String, dynamic>;
      final bahanKey = map['bahanKey'] as String;
      final quantity = map['quantity'] as String?;
      return PantryItem(
        id: bahanKey,
        userId: 'server',
        bahanKey: bahanKey,
        quantity: quantity,
        createdAt: DateTime.now(),
      );
    }).toList();
  }
}

class PantryRepository {
  PantryRepository(this._db, this._remote);

  final AppDatabase _db;
  final PantryRemoteSource _remote;
  Future<void> _pushQueue = Future.value();

  Future<List<PantryItem>> getLocalItems() async {
    final entries = await _db.select(_db.pantryTable).get();
    return entries
        .map(
          (entry) => PantryItem(
            id: entry.id,
            userId: entry.userId,
            bahanKey: entry.bahanKey,
            quantity: entry.quantity,
            createdAt: entry.createdAt,
          ),
        )
        .toList();
  }

  Future<void> setLocalItems(List<PantryItem> items) async {
    await _db.transaction(() async {
      await _db.delete(_db.pantryTable).go();
      for (final item in items) {
        await _db
            .into(_db.pantryTable)
            .insert(
              PantryEntry(
                id: item.id,
                userId: item.userId,
                bahanKey: item.bahanKey,
                quantity: item.quantity,
                createdAt: item.createdAt,
                updatedAt: DateTime.now(),
              ),
            );
      }
    });
  }

  Future<void> refreshItems() async {
    try {
      if (await _hasPendingPantryOutbox()) {
        return;
      }

      final remoteItems = await _remote.getItems();
      await setLocalItems(remoteItems);
    } catch (_) {}
  }

  Future<void> upsertPantryItem(String bahanKey, String quantity) async {
    final item = PantryItem(
      id: bahanKey,
      userId: 'local',
      bahanKey: bahanKey,
      quantity: quantity,
      createdAt: DateTime.now(),
    );

    await _db
        .into(_db.pantryTable)
        .insertOnConflictUpdate(
          PantryEntry(
            id: item.id,
            userId: item.userId,
            bahanKey: item.bahanKey,
            quantity: item.quantity,
            createdAt: item.createdAt,
            updatedAt: DateTime.now(),
          ),
        );

    final allItems = await getLocalItems();
    final outboxId = await _queueOutbox('pantry', 'replace', {
      'items': allItems
          .map((item) => {'bahanKey': item.bahanKey, 'quantity': item.quantity})
          .toList(),
    });

    _enqueuePush(allItems, outboxId);
  }

  Future<void> addPantryItem(String bahanKey, {String quantity = '1'}) async {
    await upsertPantryItem(bahanKey, quantity);
  }

  Future<void> deletePantryItem(String id) async {
    await (_db.delete(_db.pantryTable)..where((table) => table.id.equals(id)))
        .go();

    final allItems = await getLocalItems();
    final outboxId = await _queueOutbox('pantry', 'replace', {
      'items': allItems
          .map((item) => {'bahanKey': item.bahanKey, 'quantity': item.quantity})
          .toList(),
    });

    _enqueuePush(allItems, outboxId);
  }

  void _enqueuePush(List<PantryItem> items, int outboxId) {
    _pushQueue = _pushQueue.then((_) => _pushItems(items, outboxId));
    unawaited(_pushQueue);
  }

  Future<void> _pushItems(List<PantryItem> items, int outboxId) async {
    try {
      await _remote.replaceItems(items);
      await _markPantryOutboxDoneThrough(outboxId);
    } catch (_) {}
  }

  Future<int> _queueOutbox(
    String entity,
    String operation,
    Map<String, dynamic> payload,
  ) async {
    return _db
        .into(_db.outboxTable)
        .insert(
          OutboxTableCompanion.insert(
            entity: entity,
            operation: operation,
            payloadJson: jsonEncode(payload),
          ),
        );
  }

  Future<bool> _hasPendingPantryOutbox() async {
    final pending =
        await (_db.select(_db.outboxTable)
              ..where(
                (table) =>
                    table.entity.equals('pantry') &
                    table.operation.equals('replace') &
                    table.status.equals('pending'),
              )
              ..limit(1))
            .get();
    return pending.isNotEmpty;
  }

  Future<void> _markPantryOutboxDoneThrough(int outboxId) async {
    await (_db.update(_db.outboxTable)..where(
          (table) =>
              table.id.isSmallerOrEqualValue(outboxId) &
              table.entity.equals('pantry') &
              table.operation.equals('replace') &
              table.status.equals('pending'),
        ))
        .write(
          OutboxTableCompanion(
            status: const drift.Value('done'),
            updatedAt: drift.Value(DateTime.now()),
          ),
        );
  }
}
