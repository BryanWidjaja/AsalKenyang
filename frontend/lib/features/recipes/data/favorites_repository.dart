import 'dart:convert';
import 'dart:async';

import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/db/app_database.dart';
import '../../../core/sync/sync_engine.dart';
import '../../budget/data/budget_repository.dart';

final favoritesRepositoryProvider = Provider<FavoritesRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  final syncEngine = ref.watch(syncEngineProvider);
  return FavoritesRepository(db, syncEngine);
});

class FavoritesRepository {
  final AppDatabase _db;
  final SyncEngine _syncEngine;

  FavoritesRepository(this._db, this._syncEngine);

  Stream<List<FavoritesTableData>> watchFavorites() {
    return _db.select(_db.favoritesTable).watch();
  }

  Future<void> addFavorite(String recipeId) async {
    await _db.transaction(() async {
      await _db
          .into(_db.favoritesTable)
          .insert(
            FavoritesTableCompanion.insert(recipeId: recipeId),
            mode: InsertMode.insertOrIgnore,
          );
      await _db
          .into(_db.outboxTable)
          .insert(
            OutboxTableCompanion.insert(
              entity: 'favorites',
              operation: 'insert',
              payloadJson: jsonEncode({'recipeId': recipeId}),
            ),
          );
    });
    unawaited(_syncEngine.syncOutbox());
  }

  Future<void> removeFavorite(String recipeId) async {
    await _db.transaction(() async {
      await (_db.delete(
        _db.favoritesTable,
      )..where((t) => t.recipeId.equals(recipeId))).go();
      await _db
          .into(_db.outboxTable)
          .insert(
            OutboxTableCompanion.insert(
              entity: 'favorites',
              operation: 'delete',
              payloadJson: jsonEncode({'recipeId': recipeId}),
            ),
          );
    });
    unawaited(_syncEngine.syncOutbox());
  }
}
