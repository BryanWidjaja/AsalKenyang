import 'package:freezed_annotation/freezed_annotation.dart';

part 'budget_models.freezed.dart';
part 'budget_models.g.dart';

@freezed
abstract class Wallet with _$Wallet {
  const factory Wallet({
    required String id,
    required String userId,
    required int totalBudget,
    @Default(true) bool monthlyReset,
    @Default(1) int startDay,
  }) = _Wallet;

  factory Wallet.fromJson(Map<String, dynamic> json) => _$WalletFromJson(json);
}

@freezed
abstract class Spending with _$Spending {
  const factory Spending({
    required String id,
    required String userId,
    required String walletId,
    required int amount,
    required DateTime date,
    required String title,
    required List<String> tags,
  }) = _Spending;

  factory Spending.fromJson(Map<String, dynamic> json) => _$SpendingFromJson(json);
}
