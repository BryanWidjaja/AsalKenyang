import 'package:freezed_annotation/freezed_annotation.dart';

part 'recipe_models.freezed.dart';
part 'recipe_models.g.dart';

@freezed
abstract class Bahan with _$Bahan {
  const factory Bahan({
    required String nama,
    required String jumlah,
    required int harga,
    required String key,
  }) = _Bahan;

  factory Bahan.fromJson(Map<String, dynamic> json) => _$BahanFromJson(json);
}

@freezed
abstract class Recipe with _$Recipe {
  const factory Recipe({
    required String id,
    required String name,
    required String kategori,
    required int porsi,
    required int estPrice,
    required int estCalories,
    required int cookTime,
    required String imageUrl,
    required List<String> alat,
    required List<Bahan> bahan,
    required List<String> bahanKey,
    required List<String> langkah,
    required List<String> tags,
    required bool halal,
  }) = _Recipe;

  factory Recipe.fromJson(Map<String, dynamic> json) => _$RecipeFromJson(json);
}
