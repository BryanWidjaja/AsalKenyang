// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pantry_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PantryItem _$PantryItemFromJson(Map<String, dynamic> json) => _PantryItem(
  id: json['id'] as String,
  userId: json['userId'] as String,
  bahanKey: json['bahanKey'] as String,
  quantity: json['quantity'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$PantryItemToJson(_PantryItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'bahanKey': instance.bahanKey,
      'quantity': instance.quantity,
      'createdAt': instance.createdAt.toIso8601String(),
    };
