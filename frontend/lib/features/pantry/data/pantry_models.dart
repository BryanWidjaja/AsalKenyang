import 'package:freezed_annotation/freezed_annotation.dart';

part 'pantry_models.freezed.dart';
part 'pantry_models.g.dart';

@freezed
abstract class PantryItem with _$PantryItem {
  const factory PantryItem({
    required String id,
    required String userId,
    required String bahanKey,
    String? quantity,
    required DateTime createdAt,
  }) = _PantryItem;

  factory PantryItem.fromJson(Map<String, dynamic> json) => _$PantryItemFromJson(json);
}
