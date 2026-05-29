// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Wallet _$WalletFromJson(Map<String, dynamic> json) => _Wallet(
  id: json['id'] as String,
  userId: json['userId'] as String,
  totalBudget: (json['totalBudget'] as num).toInt(),
  monthlyReset: json['monthlyReset'] as bool? ?? true,
  startDay: (json['startDay'] as num?)?.toInt() ?? 1,
);

Map<String, dynamic> _$WalletToJson(_Wallet instance) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'totalBudget': instance.totalBudget,
  'monthlyReset': instance.monthlyReset,
  'startDay': instance.startDay,
};

_Spending _$SpendingFromJson(Map<String, dynamic> json) => _Spending(
  id: json['id'] as String,
  userId: json['userId'] as String,
  walletId: json['walletId'] as String,
  amount: (json['amount'] as num).toInt(),
  date: DateTime.parse(json['date'] as String),
  title: json['title'] as String,
  tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
);

Map<String, dynamic> _$SpendingToJson(_Spending instance) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'walletId': instance.walletId,
  'amount': instance.amount,
  'date': instance.date.toIso8601String(),
  'title': instance.title,
  'tags': instance.tags,
};
