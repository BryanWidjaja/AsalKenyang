import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/di/providers.dart';

final planRemoteSourceProvider = Provider<PlanRemoteSource>((ref) {
  return PlanRemoteSource(ref.watch(dioProvider));
});

class PlanRemoteSource {
  const PlanRemoteSource(this._dio);
  final Dio _dio;

  Future<void> addMeal(String id, DateTime date, String recipeId, String mealSlot) async {
    await replaceWeek(_startOfWeek(date), [
      {
        'dayIndex': date.difference(_startOfWeek(date)).inDays,
        'mealSlot': mealSlot,
        'recipeId': recipeId,
      },
    ]);
  }

  Future<void> removeMeal(String id) async {
    // The backend owns meal plans as whole-week resources. Deletes are synced
    // by SyncEngine using the local week snapshot.
  }

  Future<void> replaceWeek(
    DateTime weekStart,
    List<Map<String, Object?>> entries,
  ) async {
    await _dio.put('/meal-plan', data: {
      'weekStart': _dateKey(weekStart),
      'entries': entries,
    });
  }

  DateTime _startOfWeek(DateTime date) {
    final local = DateTime(date.year, date.month, date.day);
    return local.subtract(Duration(days: local.weekday - DateTime.monday));
  }

  String _dateKey(DateTime date) {
    return '${date.year.toString().padLeft(4, '0')}-'
        '${date.month.toString().padLeft(2, '0')}-'
        '${date.day.toString().padLeft(2, '0')}';
  }
}
