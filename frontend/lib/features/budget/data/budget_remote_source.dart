import 'package:dio/dio.dart';
import 'budget_models.dart';

class BudgetRemoteSource {
  const BudgetRemoteSource(this._dio);
  final Dio _dio;

  Future<Wallet?> getWallet() async {
    final res = await _dio.get('/budget');
    if (res.data == null) return null;
    return _walletFromBudgetDto(Map<String, dynamic>.from(res.data as Map));
  }

  Future<Wallet> updateWallet(int totalBudget) async {
    final res = await _dio.put('/budget', data: {'amount': totalBudget});
    return _walletFromBudgetDto(Map<String, dynamic>.from(res.data as Map));
  }

  Future<List<Spending>> getSpendings() async {
    final res = await _dio.get('/budget/spending');
    final data = Map<String, dynamic>.from(res.data as Map);
    final month = data['month'] as String? ?? _currentMonth();
    final entries = data['entries'] as List? ?? const [];
    return entries
        .map(
          (e) => _spendingFromDto(Map<String, dynamic>.from(e as Map), month),
        )
        .toList();
  }

  Future<Spending> addSpending(
    int amount,
    String title,
    List<String> tags,
  ) async {
    String? recipeId;
    for (final tag in tags) {
      if (tag.startsWith('recipe:')) {
        recipeId = tag.substring('recipe:'.length);
        break;
      }
    }
    final res = await _dio.post(
      '/budget/spending',
      data: {
        'amount': amount,
        'kind': tags.contains('cook') ? 'cook' : 'manual',
        'recipeId': ?recipeId,
        'note': title,
      },
    );
    return _spendingFromDto(
      Map<String, dynamic>.from(res.data as Map),
      _currentMonth(),
    );
  }

  Future<void> deleteSpending(String id) async {}

  Wallet _walletFromBudgetDto(Map<String, dynamic> json) {
    final month = json['month'] as String? ?? _currentMonth();
    return Wallet(
      id: 'budget_$month',
      userId: 'server',
      totalBudget: json['amount'] as int? ?? 0,
      monthlyReset: true,
      startDay: 1,
    );
  }

  Spending _spendingFromDto(Map<String, dynamic> json, String month) {
    final kind = json['kind'] as String? ?? 'manual';
    final recipeId = json['recipeId'] as String?;
    return Spending(
      id: json['id'] as String,
      userId: 'server',
      walletId: 'budget_$month',
      amount: json['amount'] as int? ?? 0,
      date:
          DateTime.tryParse(json['createdAt'] as String? ?? '') ??
          DateTime.now(),
      title:
          json['note'] as String? ??
          (kind == 'cook' ? 'Masak resep' : 'Pengeluaran manual'),
      tags: [kind, if (recipeId != null) 'recipe:$recipeId'],
    );
  }

  String _currentMonth() {
    final now = DateTime.now().toUtc();
    return '${now.year.toString().padLeft(4, '0')}-${now.month.toString().padLeft(2, '0')}';
  }
}
