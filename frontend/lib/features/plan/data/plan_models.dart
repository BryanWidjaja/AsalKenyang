import 'package:freezed_annotation/freezed_annotation.dart';

part 'plan_models.freezed.dart';
part 'plan_models.g.dart';

@freezed
abstract class PlannedMeal with _$PlannedMeal {
  const factory PlannedMeal({
    required String id,
    required DateTime date,
    required String recipeId,
    required String mealSlot,
  }) = _PlannedMeal;

  factory PlannedMeal.fromJson(Map<String, dynamic> json) => _$PlannedMealFromJson(json);
}
