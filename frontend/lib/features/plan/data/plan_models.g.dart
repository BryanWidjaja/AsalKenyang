// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plan_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PlannedMeal _$PlannedMealFromJson(Map<String, dynamic> json) => _PlannedMeal(
  id: json['id'] as String,
  date: DateTime.parse(json['date'] as String),
  recipeId: json['recipeId'] as String,
  mealSlot: json['mealSlot'] as String,
);

Map<String, dynamic> _$PlannedMealToJson(_PlannedMeal instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date.toIso8601String(),
      'recipeId': instance.recipeId,
      'mealSlot': instance.mealSlot,
    };
