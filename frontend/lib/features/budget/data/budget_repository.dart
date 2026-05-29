import 'dart:async';
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/db/app_database.dart';
import '../../../core/di/providers.dart';
import 'budget_models.dart';
import 'budget_remote_source.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase(); // Typically singleton across app
});

final budgetRemoteSourceProvider = Provider<BudgetRemoteSource>((ref) {
  return BudgetRemoteSource(ref.watch(dioProvider));
});

final budgetRepositoryProvider = Provider<BudgetRepository>((ref) {
  return BudgetRepository(
    ref.watch(appDatabaseProvider),
    ref.watch(budgetRemoteSourceProvider),
  );
});

class BudgetRepository {
  const BudgetRepository(this._db, this._remote);

  final AppDatabase _db;
  final BudgetRemoteSource _remote;

  // Wallet
  Future<Wallet?> getLocalWallet() async {
    final rows = await _db.select(_db.budgetTable).get();
    final entry = rows.isEmpty ? null : rows.first;
    if (entry == null) return null;
    return Wallet(
      id: entry.id,
      userId: entry.userId,
      totalBudget: entry.totalBudget,
      monthlyReset: entry.monthlyReset,
      startDay: entry.startDay,
    );
  }

  Future<void> setLocalWallet(Wallet wallet) async {
    await _db.transaction(() async {
      await _db.delete(_db.budgetTable).go();
      await _db
          .into(_db.budgetTable)
          .insert(
            BudgetEntry(
              id: wallet.id,
              userId: wallet.userId,
              totalBudget: wallet.totalBudget,
              monthlyReset: wallet.monthlyReset,
              startDay: wallet.startDay,
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            ),
          );
    });
  }

  Future<void> refreshWallet() async {
    try {
      final remoteWallet = await _remote.getWallet();
      if (remoteWallet != null) {
        await setLocalWallet(remoteWallet);
      }
    } catch (_) {
      // Offline, ignore
    }
  }

  Future<void> updateBudget(int totalBudget) async {
    // 1. Optimistic update
    final current = await getLocalWallet();
    final updated =
        (current ??
                const Wallet(
                  id: 'budget_local',
                  userId: 'local',
                  totalBudget: 0,
                ))
            .copyWith(totalBudget: totalBudget);
    await setLocalWallet(updated);

    // 2. Queue in outbox
    await _queueOutbox('wallet', 'update', updated.toJson());

    // 3. Push in the background so the UI does not feel stuck when offline.
    unawaited(_pushBudgetUpdate(totalBudget));
  }

  // Spendings
  Future<List<Spending>> getLocalSpendings() async {
    final entries = await _db.select(_db.spendingTable).get();
    return entries
        .map(
          (e) => Spending(
            id: e.id,
            userId: e.userId,
            walletId: e.walletId,
            amount: e.amount,
            date: e.date,
            title: e.title,
            tags: List<String>.from(jsonDecode(e.tags)),
          ),
        )
        .toList();
  }

  Future<void> setLocalSpendings(List<Spending> spendings) async {
    await _db.transaction(() async {
      await _db.delete(_db.spendingTable).go(); // Naive replace for now
      for (final s in spendings) {
        await _db
            .into(_db.spendingTable)
            .insert(
              SpendingEntry(
                id: s.id,
                userId: s.userId,
                walletId: s.walletId,
                amount: s.amount,
                date: s.date,
                title: s.title,
                tags: jsonEncode(s.tags),
                createdAt: DateTime.now(),
                updatedAt: DateTime.now(),
              ),
            );
      }
    });
  }

  Future<void> refreshSpendings() async {
    try {
      final remoteSpendings = await _remote.getSpendings();
      await setLocalSpendings(remoteSpendings);
    } catch (_) {
      // Offline, ignore
    }
  }

  Future<void> addSpending(int amount, String title, List<String> tags) async {
    final currentWallet = await getLocalWallet();
    final walletId = currentWallet?.id ?? 'budget_local';
    final userId = currentWallet?.userId ?? 'local';

    final tempId = 'temp_${DateTime.now().millisecondsSinceEpoch}';
    final spending = Spending(
      id: tempId,
      userId: userId,
      walletId: walletId,
      amount: amount,
      date: DateTime.now(),
      title: title,
      tags: tags,
    );

    // 1. Optimistic write
    await _db
        .into(_db.spendingTable)
        .insert(
          SpendingEntry(
            id: spending.id,
            userId: spending.userId,
            walletId: spending.walletId,
            amount: spending.amount,
            date: spending.date,
            title: spending.title,
            tags: jsonEncode(spending.tags),
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
        );

    // 2. Queue
    await _queueOutbox('spending', 'insert', spending.toJson());

    // 3. Push in the background so the Masak action completes immediately.
    unawaited(_pushSpending(amount, title, tags, tempId));
  }

  Future<void> _pushBudgetUpdate(int totalBudget) async {
    try {
      final remote = await _remote.updateWallet(totalBudget);
      await setLocalWallet(remote);
    } catch (_) {}
  }

  Future<void> _pushSpending(
    int amount,
    String title,
    List<String> tags,
    String tempId,
  ) async {
    try {
      final remote = await _remote.addSpending(amount, title, tags);
      await (_db.update(
        _db.spendingTable,
      )..where((t) => t.id.equals(tempId))).write(
        SpendingEntry(
          id: remote.id,
          userId: remote.userId,
          walletId: remote.walletId,
          amount: remote.amount,
          date: remote.date,
          title: remote.title,
          tags: jsonEncode(remote.tags),
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );
    } catch (_) {}
  }

  Future<void> _queueOutbox(
    String entity,
    String op,
    Map<String, dynamic> payload,
  ) async {
    await _db
        .into(_db.outboxTable)
        .insert(
          OutboxTableCompanion.insert(
            entity: entity,
            operation: op,
            payloadJson: jsonEncode(payload),
          ),
        );
  }
}
