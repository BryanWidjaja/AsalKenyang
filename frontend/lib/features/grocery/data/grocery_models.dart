import 'package:freezed_annotation/freezed_annotation.dart';

part 'grocery_models.freezed.dart';
part 'grocery_models.g.dart';

@freezed
abstract class GroceryItemState with _$GroceryItemState {
  const factory GroceryItemState({
    required String bahanKey,
    required bool isChecked,
  }) = _GroceryItemState;

  factory GroceryItemState.fromJson(Map<String, dynamic> json) => _$GroceryItemStateFromJson(json);
}
